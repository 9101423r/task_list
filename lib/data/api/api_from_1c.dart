import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';

class ApiFromServer {
  Future<int> getId() {
    int id = (DateTime.now().microsecond + DateTime.now().millisecond);
    return Future.value(id);
  }

  String username = 'Пак В';
  String password = '111';
  final dio = Dio();

  Future<List<dynamic>> getListCompany() async {
    // Возвращаю лист [Первое refKey, второе Лист из название]
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
      print('result: ${result}');
      return [refKeyUser, result];
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getTypeTaskFromServer() async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}'; // Без late указывает ошибку
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
      print(result);
      return [refKeyTask, result];
    } else {
      return [];
    }
  }
}
