// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImportantFieldsAdapter extends TypeAdapter<ImportantFields> {
  @override
  final int typeId = 2;

  @override
  ImportantFields read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImportantFields(
      someImportantMaps: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ImportantFields obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.someImportantMaps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImportantFieldsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
