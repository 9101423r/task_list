
import 'package:hive/hive.dart';
part 'task.g.dart';


@HiveType(typeId:1)
class Task {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  String descriptions;
  @HiveField(4)
  int status;
  @HiveField(5)
  double hours;
  @HiveField(6)
  String temporaryUUID;
  @HiveField(7)
  List<String> comments;
  Task(
      {
        required this.id,
        required this.title,        
        required this.descriptions,
      required this.status,
      required this.hours,
      required this.temporaryUUID,
      required this.comments,
});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      descriptions: json['descriptions'],
      status: json['status'],
      hours: json['hours'] as double,
      temporaryUUID: json['temporaryUUID'],
      comments: List<String>.from(json['comments'] ?? []),
    );
  }
}
