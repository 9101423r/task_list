import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/task_model.dart';

class StatusChoise extends StatelessWidget {
  final Task task;
  const StatusChoise({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> choices = ['1', '2', '3', '4', '5'];
    return BlocBuilder<EditTaskBloc, EditTaskState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: PromptedChoice<String>.single(
            title: 'Status',
            value: task.status.toString(),
            onChanged: (value) {
              context
                  .read<EditTaskBloc>()
                  .add(ChangeStatus(task: task, status: value!));
            },
            itemCount: choices.length,
            itemBuilder: (state, i) {
              return RadioListTile(
                value: choices[i],
                groupValue: state.single,
                onChanged: (value) {
                  state.select(choices[i]);
                },
                title: ChoiceText(
                  choices[i],
                  highlight: state.search?.value,
                ),
              );
            },
            promptDelegate: ChoicePrompt.delegateBottomSheet(),
            anchorBuilder: ChoiceAnchor.create(inline: true),
          ),
        );
      },
    );
  }
}
