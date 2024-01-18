import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

class ApiFromServer {
  String username = 'Пак В';
  String password = '111';
  final dio = Dio();

  Future<List<List<String>>> getListCompany() async {
    // Возвращаю лист [Первое Лист из refKey, второе Лист из название]
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    dio.options.headers["authorization"] = basicAuth;
    late final response;
    try {
      response = await dio.get(
          'http://192.168.1.15/Base/odata/standard.odata/Catalog_Контрагенты?\$format=application/json');
    } on DioException catch (e) {
      dev.log(e.toString());
    }
    if (response != null) {
      List<String> refKeyUser = [];

      var contragentList = response.data['value'] as List;
      List<String> result = [];

      for (var i = 0; i < contragentList.length; i++) {
        result.add(contragentList[i]['Description']);

        refKeyUser.add(contragentList[i]['Ref_Key']);
      }
      print("we returning first :${[refKeyUser]}");
      print("we returning second :${[result]}");
      return [refKeyUser.toList(), result.toList()];
    } else {
      return [];
    }
  }

  Future<List<List<String>>> getTypeTaskFromServer() async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    dio.options.headers["authorization"] = basicAuth;
    late final response;
    try {
      response = await dio.get(
          'http://192.168.1.15/BaseDev/odata/standard.odata/Catalog_Номенклатура?\$format=json&\$filter=ТипНоменклатуры%20eq%20%27Услуга%27'); // Два слеше перед доллар чекнуть
    } on DioException catch (e) {
      dev.log(e.toString());
    } catch (e) {
      dev.log(e.toString());
    }
    if (response != null) {
      List<String> refKeyTask = [];

      List<String> result = [];
      var typeTask = response.data['value'] as List;

      for (var i = 0; i < typeTask.length; i++) {
        result.add(typeTask[i]['Description']);
        refKeyTask.add(typeTask[i]['Ref_Key']);
      }
      ImportantFieldsLocalStorage().box.isEmpty // TODO 
          ? ImportantFieldsLocalStorage().saveMapValues(refKeyTask, result)
          : {};

      return [refKeyTask, result];
    } else {
      return [];
    }
  }

  Future<Task> postTaskForServer(Task postTask, String companyID) async {
    const postAdress =
        'http://192.168.1.15/BaseDev/odata/standard.odata/Document_СозданиеЗаявки?\$format=json';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    dio.options.headers["authorization"] = basicAuth;

    late final Response resultResponse;
    print("Is it printed PostTaskForServer1");
    print(postTask);

    try {
      resultResponse =
          await dio.post(postAdress, data: postTask.toMap(companyID));
      print('ISit printed: $resultResponse');
      if (resultResponse.statusCode == 201) {
        Task task = Task.fromJson(resultResponse.data);
        return task;
      }
    } on DioException catch (dioErrors) {
      // TODO show snackbar if POST request failure
      print("Is it printed PostTaskForServer1 DioExceptions");
      dev.log(dioErrors.toString());
      return postTask;
    } catch (error) {
      dev.log('PostTaskForServer: $error');
      return postTask;
    }
    return postTask;
  }

  Future<List<Task>> getTasksFromServer(List<Task> listTask) async {
    const url =
        'http://192.168.1.15/BaseDev/odata/standard.odata/Document_СозданиеЗаявки?\$format=application/json&\$filter=';

    // TODO
    List<String> idList = listTask
        .where((task) => task.temporaryUUID == 'null')
        .map((task) => task.id.toString())
        .toList();

    var newUrl = url + idList.map((e) => "Number eq $e").join(' or ');

    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    dio.options.headers["authorization"] = basicAuth;

    late final Response resultResponse;

    try {
      resultResponse = await dio.get(newUrl);
      if (resultResponse.statusCode == 200) {
        if (resultResponse.data != null) {
          var resultList = <Task>[];
          var result = resultResponse.data['value'];
          for (var i in result) {
            // // print((i['Комментарии'][0]['Время']).toString());
            // if(Task.fromJson(i).id == 7180 ){
            // print((i['Комментарии'][0]['Время']).toString());}
            // print("Task.fromJson: ${Task.fromJson(i)}");
            resultList.add(Task.fromJson(i));
            // TODO create local list<String> ref_key and typeTask и сопоставить значение
          }
          return resultList;
        }
        return [];
      }
    } on DioException catch (dioErrors) {
      dev.log(dioErrors.toString());
    } catch (error) {
      dev.log('PostTaskForServer: $error');
    }
    return listTask;
  }
}
