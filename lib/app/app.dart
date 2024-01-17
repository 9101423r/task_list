import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:task_list/app/app_view.dart';

import 'package:task_list/domain/provider/locale_provider.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(), child: const MyAppView());
  }
}
