

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';



Future<void> openBox() async{
 
      final documentDirectory = await getApplicationDocumentsDirectory();
        Hive.init(documentDirectory.path);

  
 
  // if(!Hive.isAdapterRegistered(14)){
  //    Hive.resetAdapters();
  //   Hive.registerAdapter(CommentAdapter());
  // }
  await openBox1();
  await openBox2();

//  if(!Hive.isAdapterRegistered(0)){
  
//     Hive.registerAdapter(TaskAdapter());
//   }
//   else{
//     print("nothing1");
//   }
//   if(!Hive.isAdapterRegistered(46)){
  
//     Hive.registerAdapter(TaskAdapter());
//   }
//   else{
//     print("nothing2");
//   }
}


openBox1()async{
  try {
  
  
  await Hive.openBox<Task>('taskBox');
Hive.registerAdapter(TaskAdapter());
} on Exception catch (error) {   
  print('Ошибка при открытии Box: $error');
}
}

openBox2() async{
  try {
await Hive.openBox<Comment>('commentBox');
  Hive.registerAdapter(CommentAdapter());

} on Exception catch (error) {
  print('Ошибка при открытии Box: $error');
}
}