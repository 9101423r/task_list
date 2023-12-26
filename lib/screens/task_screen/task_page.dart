import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/comments_model.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/screens/task_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/task_screen/widgets/comments_show.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({required this.task, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final box = Hive.box<Comment>('commentBox');

  @override
  void initState() {
    super.initState();
    box.watch().listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  String? singleSelected;

  void setSingleSelected(String? value) {
    setState(() {
      singleSelected = value;
      widget.task.status = int.parse(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Name: ${widget.task.title}'),
            Text('Descriptions: ${widget.task.descriptions}', maxLines: 6),
            myChoise(),
            Text('Hour :${widget.task.hours}'),
            Row(
              children: [
                const Expanded(child: Text('Comments')),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => EditTaskBloc(),
                              child: MyAlertDialogForAddingComment(
                                  task: widget.task),
                            );
                          });
                    },
                    child: Text(AppLocalizations.of(context)!.addComment))
              ],
            ),
            const Divider(),
            CommentsListView(task: widget.task, boxComments: box),
          ]),
        ));
  }

  Widget myChoise() {
    List<String> choices = ['1', '2', '3', '4', '5'];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: PromptedChoice<String>.single(
        title: 'Status',
        value: widget.task.status.toString(),
        onChanged: setSingleSelected,
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
  }
}
