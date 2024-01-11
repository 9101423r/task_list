import 'dart:convert';

import 'package:dio/dio.dart';

class ApiFromServer {
  Future<int> getId() {
    int id = (DateTime.now().microsecond + DateTime.now().millisecond);
    print(id);
    return Future.value(id);
  }

  Future<List<String>> getListCompany() async {
    String username = 'Пак В';
    String password = '111';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    final dio = Dio();
    dio.options.headers["authorization"] = basicAuth;
    print('Something1 ');
    // try{
    final response = await dio.get(
        'http://192.168.1.15/Base/odata/standard.odata/Catalog_Контрагенты?\$format=application/json');

    print('Response status: ${response.statusMessage}');
    print('Something2 ');
    print('Responce tpString(): ${response.toString()}');
    var contragentList = response.data['value'] as List;
    List<String> result = [];

    for (var i = 0; i < contragentList.length; i++) {
      result.add(contragentList[i]['Description']);
    }
    print(result);

    return result;
    //}/
//  on Exception catch(error){
//   print('Ошибка при получение данных: $error');
//   return ['Safsf','asfasf'];
//  }
  }
}
