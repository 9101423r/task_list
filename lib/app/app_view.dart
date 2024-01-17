import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_list/app/app_home.dart';

import 'package:task_list/constants/app_theme.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/domain/provider/locale_provider.dart';
import 'package:task_list/l10n/all_locales.dart';
import 'package:task_list/screens/task_screen/task_page.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
        title: 'TaskList',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: localeProvider.locale,
        supportedLocales: AllLocale.all,
        theme: AppTheme.mainTheme,
        onGenerateRoute: (routes) {
          if (routes.name == '/task_screen') {
            final Task task = routes.arguments as Task;
            return MaterialPageRoute(
              builder: (context) => TaskPage(task: task),
            );
          }
          return null;
        },
        home: const AppHome());
  }
}
