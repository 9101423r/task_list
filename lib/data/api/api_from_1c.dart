import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

class ApiFromServer {
  final dio = Dio();

  final box = ImportantFieldsLocalStorage().box;
  Map<String, String>? myJson =
      ImportantFieldsLocalStorage().box.get(1)!.someImportantMaps['json'];

  String getName() {
    return myJson!["ADMIN_NAME"]!;
  }

  String getPassword() {
    return myJson!["ADMIN_PASSWORD"]!;
  }

  Future<List<List<String>>> getListCompany() async {
    print(myJson);
    String name = myJson!["ADMIN_NAME"]!;
    String password = myJson!["ADMIN_PASSWORD"]!;

    // Возвращаю лист [Первое Лист из refKey, второе Лист из название]
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$name:$password'))}';

    dio.options.headers["authorization"] = basicAuth;
    late final Response response;
    try {
      response = await dio.get(myJson!["API_URL_1C_WITH_COMPANY_LIST"]!);
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
    String name = myJson!["ADMIN_NAME"]!;
    String password = myJson!["ADMIN_PASSWORD"]!;

    String basicAuth = 'Basic ${base64.encode(utf8.encode('$name:$password'))}';

    dio.options.headers["authorization"] = basicAuth;
    late final Response response;
    try {
      response = await dio.get(myJson![
          "API_URL_1C_WITH_TYPE_LIST"]!); // Два слеше перед доллар чекнуть
    } on DioException catch (e) {
      dev.log(e.toString());
    } catch (e) {
      dev.log(e.toString());
    }
    if (response.data != null) {
      List<String> refKeyTask = [];

      List<String> result = [];
      var typeTask = response.data['value'] as List;

      for (var i = 0; i < typeTask.length; i++) {
        result.add(typeTask[i]['Description']);
        refKeyTask.add(typeTask[i]['Ref_Key']);
      }
      print('result: $result');
      print('refKeyTask:$refKeyTask');
      ImportantFieldsLocalStorage().saveTypeTask(refKeyTask, result);

      return [refKeyTask, result];
    } else {
      return [];
    }
  }

  Future<Task> postTaskForServer(Task postTask, String companyID) async {
    String name = myJson!["ADMIN_NAME"]!;
    String password = myJson!["ADMIN_PASSWORD"]!;

    // Возвращаю лист [Первое Лист из refKey, второе Лист из название]
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$name:$password'))}'; // TODO прямое передача из json вызывает 401 от сервера

    late final Response resultResponse;
    dio.options.headers["authorization"] = basicAuth;

    try {
      resultResponse = await dio.post(myJson!["API_URL_1C_WITH_POST_TASK"]!,
          data: postTask.toMap(companyID));
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
    List<String> idList = listTask
        .where((task) => task.temporaryUUID == 'null')
        .map((task) => task.id.toString())
        .toList();

    var newUrl = myJson!["API_URL_1C_TASK_LIST"]! +
        idList.map((e) => "Number eq $e").join(' or ');
    String name = myJson!["ADMIN_NAME"]!;
    String password = myJson!["ADMIN_PASSWORD"]!;

    String basicAuth = 'Basic ${base64.encode(utf8.encode('$name:$password'))}';

    dio.options.headers["authorization"] = basicAuth;
    late final Response resultResponse;

    try {
      resultResponse = await dio.get(newUrl);
      if (resultResponse.statusCode == 200) {
        if (resultResponse.data != null) {
          var resultList = <Task>[];
          var result = resultResponse.data['value'];
          for (var i in result) {
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
