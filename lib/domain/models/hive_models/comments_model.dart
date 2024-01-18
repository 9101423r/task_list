import 'package:hive/hive.dart';
part 'comments_model.g.dart';

@HiveType(typeId: 1)
class Comment {
  @HiveField(8)
  String author;
  @HiveField(9)
  String timeLikeID;
  @HiveField(10)
  String descriptions;

  Comment(
      {required this.author,
      required this.timeLikeID,
      required this.descriptions});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        author: json['Автор'],
        timeLikeID: json['Время'],
        descriptions: json['Комментарий']);
  }

  Map toMap(String userRefKey) {
    var map = <String, dynamic>{};
    map['Ref_Key'] = userRefKey;
    map['Автор'] = author;
    map['Время'] = timeLikeID;
    map['Комментарий'] = descriptions;
    map['ИзменениеСтатуса'] = '';
    map['Реквизит1'] = '';

    return map;
  }

  @override
  String toString() {
    return "Comment $descriptions,id:$timeLikeID";
  }
}
