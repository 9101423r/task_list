import 'package:hive/hive.dart';
import 'package:task_list/constants/validator.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  String descriptions;
  @HiveField(4)
  String status;
  @HiveField(5)
  double hours;
  @HiveField(6)
  String temporaryUUID;
  @HiveField(7)
  List<String> comments;
  @HiveField(8)
  String refKey;
  @HiveField(9)
  String typeTask;
  Task(
      {required this.id,
      required this.title,
      required this.descriptions,
      required this.status,
      required this.hours,
      required this.temporaryUUID,
      required this.comments,
      required this.refKey,
      required this.typeTask});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: int.parse(json['Number']),
        title: json['КраткоеОписание'],
        descriptions: json['ПодробноеОписание'],
        status: json['Статус'],
        hours: (json['ЗатраченноеВремя']).toDouble(),
        temporaryUUID: 'null',
        comments: List<String>.from(
          json['Комментарии'] ?? [],
        ),
        refKey: json['Исполнитель_Key'],
        typeTask: json['ТипЗадачи_Key']);
  }

  Map toMap(String userRefKey) {
    DateTime now = DateTime.now();
    var map = <String, dynamic>{};
    map["DeletionMark"] = false;
    map["Date"] = Validator().customDateFormatter(now);
    map["Posted"] = true;
    map["Клиент_Key"] = userRefKey;
    map["ТипЗадачи_Key"] = refKey;
    map["КраткоеОписание"] = title;
    map["ПодробноеОписание"] = descriptions;
    map["Создатель_Key"] = "963be8af-302d-11ee-8c7b-000c292a705c";
    map["Исполнитель_Key"] = "89a6a0aa-c7ac-11ec-9a7b-1078d2d60194";
    map["Срок"] = Validator().customPlusOneWeekDateFormatter(now);
    map["Наблюдатель_Key"] = "00000000-0000-0000-0000-000000000000";
    map["Приоритет"] = "Средний";
    map["ДатаФактическая"] = "0001-01-01T00:00:00";
    map["ДатаИзменения"] = Validator().customPlusOneWeekDateFormatter(now);
    map["ЧасыПереработки"] = 0;
    map["Статус"] = status;
    map["ЗатраченноеВремя"] = hours;
    map["Штучная"] = false;
    map["Часовая"] = false;
    map["Самостоятельность"] = "0";
    map["КачествоВыполненияРабот"] = "0";
    map["Вовлеченность"] = "0";
    map["ДатаЗакрытия"] = "0001-01-01T00:00:00";
    map["СверухрочныеРаботы"] = false;
    map["ЦенаШтучныхРабот"] = 0;
    map["ДоговорКлиента_Key"] = "00000000-0000-0000-0000-000000000000";

    map["Комментарии"] = comments;
    map["ИспользуемыеМатериалы"] = [];
    map["ЧекЛист"] = [];

    return map;
  }
}
