import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/fields.dart';

class ImportantFieldsLocalStorage {
  final box = Hive.box<ImportantFields>('importantFieldsBox');

  Future<void> createList() async {
    Map<String, Map<String, String>> listOfMaps = {};
    ImportantFields importantFields =
        ImportantFields(someImportantMaps: listOfMaps);

    box.put(1, importantFields);
  }

  void saveJson(List<String> jsonKey, List<dynamic> jsonValue) async {
    List<String> stringList = List.castFrom(jsonValue);

    Map<String, String> mapWithTJsonValueAndKeys =
        Map.fromIterables(jsonKey, stringList);

    ImportantFields importantFields = box.get(1)!;
    importantFields.someImportantMaps['json'] = mapWithTJsonValueAndKeys;

    await box.put(1, importantFields);
  }

  void saveTypeTask(
      List<String> taskRefKey, List<dynamic> taskTypeValue) async {
    ImportantFields importantFields = box.get(1)!;

    List<String> stringList = List.castFrom(taskTypeValue);

    Map<String, String> mapWithTypeTaskAndTheirRefKey =
        Map.fromIterables(taskRefKey, stringList);

    importantFields.someImportantMaps['typeTask'] =
        mapWithTypeTaskAndTheirRefKey;

    await box.put(1, importantFields);
  }

  Future<void> saveUserInfo(Map<String, dynamic> userMap) async {
    List<String> keys = List.castFrom(userMap.keys.toList());
    List<String> values = List.castFrom(userMap.values.toList());
    log(keys.toString(), name: 'UserInfoKeys');
    log(values.toString(), name: 'UserInfoValues');

    Map<String, String> mapWithUserInfoAndValue =
        Map.fromIterables(keys, values);

    ImportantFields importantFields = box.get(1)!;
    importantFields.someImportantMaps['userJson'] = mapWithUserInfoAndValue;

    await box.put(1, importantFields);
  }

  Map<String, String>? returnUserJson() {
    return box.get(1)!.someImportantMaps['userJson'];
  }

  Map<String, String>? returnTypeTaskJson() {
    return box.get(1)!.someImportantMaps['typeTask'];
  }
}
