import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/comments_model.dart';

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final typeId = 2;
  @override
  Comment read(BinaryReader reader) {
    return Comment(
      descriptions: reader.readString(),
      id: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer.writeString(obj.id);

    writer.writeString(obj.descriptions);
  }
}
