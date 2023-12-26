import 'package:flutter/material.dart';
import 'package:task_list/constants/app_text_styles.dart';

class JustText extends StatelessWidget {
  final String stringType;
  final String stringSpec;
  const JustText(
      {required this.stringType, required this.stringSpec, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$stringType : $stringSpec',
      style: AppTextStyles.h2,
    );
  }
}
