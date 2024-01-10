

import 'package:hive/hive.dart';
part 'comments_model.g.dart';

@HiveType(typeId: 0)
class Comment {
  @HiveField(8)
  String id;
  @HiveField(9)
  String descriptions;

  Comment({required this.id, required this.descriptions});

  factory Comment.toJson(Map<String, dynamic> json) {
    return Comment(id: json['id'], descriptions: json['descriptions']);
  }
}
