import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';


import 'package:task_list/domain/provider/locale_provider.dart';
import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/home_screen/widgets/home_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'), actions: [popUpMenuAppBar()]),
          body: BlocProvider(
            create: (context) => OperationForTaskBloc(),
            child: const HomeBody(),
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
                  setState(() {
                      context
              .read<OperationForTaskBloc>()
              .add(ClearBoxTapped());
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
