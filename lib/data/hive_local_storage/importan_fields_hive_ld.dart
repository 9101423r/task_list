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

  Future<void> saveUserInfo(Map<String,Object> userMap) async{
    List<String> keys = List.castFrom(userMap.keys.toList());
    List<String> values = List.castFrom(userMap.values.toList());
    print(keys);
    print(values);
    createList();

    Map<String, String> mapWithUserInfoAndValue =
        Map.fromIterables(keys, values);

    box.get(1)!.someImportantMaps['userJson'] = mapWithUserInfoAndValue;
  }

  Map<String, String>? returnUserJson(){
    return box.get(1)!.someImportantMaps['userJson'];
  }

  Map<String,String>? returnTypeTaskJson(){
    return box.get(1)!.someImportantMaps['typeTask'];
  }
}
