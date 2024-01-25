import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/home_screen/widgets/home_body/ended_tasks_body.dart';
import 'package:task_list/screens/home_screen/widgets/elements/pop_up_menu_button.dart';

import 'package:task_list/screens/home_screen/widgets/home_body/home_body.dart';
import 'package:badges/badges.dart' as badges;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((event) {
      print('FirebaseMessaging.onMessageOpenedApp.listen');
      context
          .read<OperationForTaskBloc>()
          .add(PageRefreshed(listTask: listTasks));
      log(context.read<OperationForTaskBloc>().state.taskList.toString(),
          name: 'FirebaseMessaging.onMessage state taskList');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('its  WidgetsBinding.instance.addPostFrameCallback ');
      print('its$listTasks');
      context
          .read<OperationForTaskBloc>()
          .add(PageRefreshed(listTask: listTasks));
      log(context.read<OperationForTaskBloc>().state.taskList.toString(),
          name: 'InitState addPostFrameCallback');
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    print('Приложение деактивировано');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('Приложение активировано');
      context
          .read<OperationForTaskBloc>()
          .add(PageRefreshed(listTask: listTasks));
      log(context.read<OperationForTaskBloc>().state.taskList.toString(),
          name: 'didChangeAppLifecycleState');
    }
  }

  late List<Task> listTasks = [];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        listTasks = state.taskList;
        return Scaffold(
          appBar: AppBar(
              title: const Text("Task List"),
              actions: const [PopUpMenuButton()]),
          body: LiquidPullToRefresh(
            onRefresh: () async {
              providerValue.add(PageRefreshed(listTask: state.taskList));
            },
            child: PageView(
              pageSnapping: false,
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (pageView) {
                providerValue.add(PageViewChange(
                    pageInt: pageView, pageController: pageController));
              },
              children: [
                BlocProvider.value(
                    value: providerValue, child: const HomeBody()),
                BlocProvider.value(
                    value: providerValue, child: const EndedTaskPage())
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (pageView) {
              providerValue.add(PageViewChange(
                  pageInt: pageView, pageController: pageController));
            },
            items: [
              const BottomNavigationBarItem(
                  label: 'text', icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                label: 'Just Text',
                icon: badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  position: badges.BadgePosition.topEnd(top: -14),
                  badgeContent: Text(
                    state.taskList
                        .where(
                            (element) => element.status == 'Требует Уточнения')
                        .toList()
                        .length
                        .toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.list_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: providerValue,
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
}
