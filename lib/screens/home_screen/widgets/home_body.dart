import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';


import 'package:task_list/screens/home_screen/widgets/task_card.dart';


class HomeBody extends StatelessWidget {
  final Stream<List<Task>>? stream;
  
  const HomeBody({ required this.stream,super.key});

  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
          onRefresh: ()async{
            context.read<OperationForTaskBloc>().add(PageRefreshed());
          },
          child: StreamBuilder<List<Task>>(
              stream: stream,
              builder: (context, snapshot) {
              if(snapshot.hasData){
              
                  return ListView.builder(
                    itemBuilder: (context,index){
                      return TaskCard(task : snapshot.data!.toList()[index]);
                    },
                    itemCount: snapshot.data!.toList().length
                  );
                  }
                  else{
                    return const Center(child: Text("JUST TEXT"));
                  }
            
              }),
        );
  }
}
