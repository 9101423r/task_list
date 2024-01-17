import 'package:hive_flutter/hive_flutter.dart';

part 'fields.g.dart';

@HiveType(typeId: 2)
class ImportantFields {
  @HiveField(1)
  Map<String, String> typeTaskAndRefKey;

  ImportantFields({required this.typeTaskAndRefKey});
}
