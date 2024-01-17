import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/fields.dart';

class ImportantFieldsLocalStorage {
  static String boxName = 'importantFieldsBox';
  late final box = Hive.box<ImportantFields>(boxName);

  void saveMapValues(List<String> refKey, List<String> typeTask) {
    Map<String, String> someMap = Map.fromIterables(refKey, typeTask);

    box.add(ImportantFields(typeTaskAndRefKey: someMap));
  }
}
