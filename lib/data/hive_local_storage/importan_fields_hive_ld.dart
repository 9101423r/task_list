import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/fields.dart';

class ImportantFieldsLocalStorage {
  final box = Hive.box<ImportantFields>('importantFieldsBox');

  void createList() {
    if (box.isEmpty) {
      Map<String, Map<String, String>> listOfMaps = {};
      box.put(1, ImportantFields(someImportantMaps: listOfMaps));
    }
  }

  void saveJson(List<String> jsonKey, List<dynamic> jsonValue) {
    List<String> stringList = List.castFrom(jsonValue);
    createList();

    Map<String, String> mapWithTJsonValueAndKeys =
        Map.fromIterables(jsonKey, stringList);

    box.get(1)!.someImportantMaps['json'] = mapWithTJsonValueAndKeys;
  }

  void saveTypeTask(
      List<String> taskRefKey, List<dynamic> taskTypeValue) async {
    List<String> stringList = List.castFrom(taskTypeValue);

    Map<String, String> mapWithTypeTaskAndTheirRefKey =
        Map.fromIterables(taskRefKey, stringList);

    createList();
    box.get(1)!.someImportantMaps['typeTask'] = mapWithTypeTaskAndTheirRefKey;
  }

  void saveUserInfo(List<String> userInfoKey, List<dynamic> userInfoValue) {
    List<String> stringList = List.castFrom(userInfoValue);
    createList();

    Map<String, String> mapWithUserInfoAndValue =
        Map.fromIterables(userInfoKey, stringList);

    box.get(1)!.someImportantMaps['userInfo'] = mapWithUserInfoAndValue;
  }
}
