import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';

import 'package:task_list/screens/home_screen/widgets/elements/task_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        if (state.taskList.isEmpty) {
          if (state.status == TaskStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status != TaskStatus.success) {
            return const SizedBox();
          } else {
            return const Center(child: Text('JUST TEXT'));
          }
        }
        else{

            return Stack(
              children:[ ListView.builder(
                  itemBuilder: (context, index) {
                    return  TaskCard(task: state.taskList[index]);

                  },
                  itemCount: state.taskList.length),
                if (state.status == TaskStatus.loading)
                  const Opacity(
                    opacity: 0.3,
                    child: ModalBarrier(dismissible: false, color: Colors.black),
                  ),

                if (state.status == TaskStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ]
            );
          }




      },
    );
  }
}
