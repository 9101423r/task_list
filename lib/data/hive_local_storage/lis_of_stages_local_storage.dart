import 'package:hive/hive.dart';
import 'package:task_list/domain/models/hive_models/list_of_stages.dart';

class ListOfStagesLocalStorage {
  final box = Hive.box<ListOfStages>('stageBox');

  Future<void> addStage(ListOfStages stage) async {
    await box.put(stage.descriptions, stage);
  }
}
