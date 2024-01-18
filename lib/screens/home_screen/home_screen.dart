import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';

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

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'),
              actions: const [PopUpMenuButton()]),
          body: LiquidPullToRefresh(
            onRefresh: () async {
              context
                  .read<OperationForTaskBloc>()
                  .add(PageRefreshed(listTask: state.taskList));
              print('Refreshed : true');
            },
            child: PageView(
              pageSnapping: false,
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (pageView) {
                context.read<OperationForTaskBloc>().add(PageViewChange(
                    pageInt: pageView, pageController: pageController));
              },
              children: const [HomeBody(), EndedTaskPage()],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (pageView) {
              context.read<OperationForTaskBloc>().add(PageViewChange(
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
                        .where((element) => element.status == 'Закрыта')
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
