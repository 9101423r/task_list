import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/fields.dart';

class ImportantFieldsLocalStorage {
  final box = Hive.box<ImportantFields>('importantFieldsBox');

  void createList() {
    if (box.isEmpty) {
      List<Map<String, String>> listOfMaps = [];
      box.put(1, ImportantFields(someImportantMaps: listOfMaps));
    }
  }

  void saveMapValues(List<String> refKey, List<dynamic> typeTask) async {
    List<String> stringList = List.castFrom(typeTask);

    Map<String, String> mapWithTypeTaskAndTheirRefKey =
        Map.fromIterables(refKey, stringList);
    if (mapWithTypeTaskAndTheirRefKey.isNotEmpty) {
      mapWithTypeTaskAndTheirRefKey.forEach((key, value) {
        print('$key:$value');
      });
    } else {
      print('IT IS EMPTY');
    }
    print(mapWithTypeTaskAndTheirRefKey);
    createList();
    box.get(1)!.someImportantMaps.add(mapWithTypeTaskAndTheirRefKey);
    print(
        "Box values and check have we elemets here? ::${box.get(1)!.someImportantMaps[0]}");
  }
}
