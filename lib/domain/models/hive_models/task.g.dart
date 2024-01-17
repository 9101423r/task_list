// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[1] as int,
      title: fields[2] as String,
      descriptions: fields[3] as String,
      status: fields[4] as String,
      hours: fields[5] as double,
      temporaryUUID: fields[6] as String,
      comments: (fields[7] as List).cast<Comment>(),
      refKey: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.descriptions)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.hours)
      ..writeByte(6)
      ..write(obj.temporaryUUID)
      ..writeByte(7)
      ..write(obj.comments)
      ..writeByte(8)
      ..write(obj.refKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
