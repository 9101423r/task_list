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
      typeTaskAndRefKey: (fields[1] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ImportantFields obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.typeTaskAndRefKey);
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
