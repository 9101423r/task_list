import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/fields.dart';

class ImportantFieldsLocalStorage {
  final box = Hive.box<ImportantFields>('importantFieldsBox');

  void saveMapValues(List<String> refKey, List<String> typeTask) {
    Map<String, String> someMap = Map.fromIterables(refKey, typeTask);

    box.add(ImportantFields(typeTaskAndRefKey: someMap));
  }
}
