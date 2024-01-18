// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_stages.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfStagesAdapter extends TypeAdapter<ListOfStages> {
  @override
  final int typeId = 3;

  @override
  ListOfStages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfStages(
      descriptions: fields[1] as String,
      isDone: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ListOfStages obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.descriptions)
      ..writeByte(2)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfStagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
