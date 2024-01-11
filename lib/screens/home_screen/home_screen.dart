import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/api/local_task_repository.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/domain/provider/locale_provider.dart';
import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/screens/home_screen/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tasksRepository = TaskRepository();
  // late Stream<List<Task>> _taskStream;

  @override
  void initState() {
    super.initState();
    _tasksRepository;

    print('Check hot reload + another hot reload');
  }

 @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  print(1);
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'), actions: [popUpMenuAppBar()]),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<OperationForTaskBloc>().add(PageRefreshed());
            },
            child: StreamBuilder<List<Task>>(
                stream:_tasksRepository.tasksStream,
                initialData: _tasksRepository.listTask,
                builder: (context, snapshot) {
                  print('Snapshot data: ${snapshot.data}');
print('Check List: ${_tasksRepository.listTask}');
                  if (snapshot.hasData ) {
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskCard(task: snapshot.data!.toList()[index]);
                        },
                        itemCount:snapshot.data!.toList().length);
                  } else {
                    return const Center(child: Text('JUST TEXT'));
                  }
                }),
          ),
          floatingActionButton: floatingActionButton(context),
        );
      },
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => OperationForTaskBloc(),
                child: const MyAlertWidget(),
              );
            });
      },
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }

  PopupMenuButton<dynamic> popUpMenuAppBar() {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'deleteAll',
                onTap: () {

                    context.read<OperationForTaskBloc>().add(ClearBoxTapped());

                },
                child: Text(AppLocalizations.of(context)!.clearBox),
              ),
              PopupMenuItem(
                value: 'changeLocale',
                onTap: () {
                  setState(() {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .changeLocale();
                  });
                },
                child: Text(AppLocalizations.of(context)!.changeLocale),
              ),
              PopupMenuItem(
                value: 'signOut',
                onTap: () {

                    context.read<OperationForTaskBloc>().add(SignOut());

                },
                child: const Text('LogOuT'),
              ),
            ]);
  }
}
