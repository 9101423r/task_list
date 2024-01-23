import 'package:hive_flutter/hive_flutter.dart';

part 'fields.g.dart';

@HiveType(typeId: 2)
class ImportantFields {
  @HiveField(1)
  Map<String,Map<String, String>> someImportantMaps;
  

  ImportantFields({required this.someImportantMaps});
}
