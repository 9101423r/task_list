import 'package:hive_flutter/hive_flutter.dart';

part 'list_of_stages.g.dart';



@HiveType(typeId: 3)
class ListOfStages{
  @HiveField(1)

  String descriptions;
  @HiveField(2)
  bool isDone;

  ListOfStages({required this.descriptions,required this.isDone});


  factory ListOfStages.fromJson(Map<String, dynamic> json){
    return ListOfStages(descriptions: json["Этапы"], isDone: json["ВыполненоНеВыполнено"]);
  }

  Map toMap(){
    var map = <String,dynamic>{};
    map["Ref_Key"] ="f5e5d953-b5bf-11ee-8c87-0050569ceb46";
    map["LineNumber"] = "1";
    map["Этапы"] = descriptions;
    map['ВыполненоНеВыполнено'] = isDone;
    map["ВремяВыполнения"] = "0";
    return map;
  }



}