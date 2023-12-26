import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/domain/provider/locale_provider.dart';
import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/home_screen/widgets/task_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();
    box.watch().listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    box.clear();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'), actions: [popUpMenuAppBar()]),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: box.values.map((task) => TaskCard(task: task)).toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
          ),
        );
      },
    );
  }

  PopupMenuButton<dynamic> popUpMenuAppBar() {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'deleteAll',
                onTap: () {
                  setState(() {
                    box.clear();
                  });
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
            ]);
  }
}
