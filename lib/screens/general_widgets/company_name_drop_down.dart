import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/drop_down_bloc/drop_down_bloc.dart';

class DropDownWithRefKeyAndChangeValue extends StatelessWidget {
  final Future<List<dynamic>> getFutureList;
  const DropDownWithRefKeyAndChangeValue(
      {required this.getFutureList,
      required this.onRefKeyGetIt,
      required this.onDropDownValueChoose,
      super.key});
  final ValueChanged<String> onRefKeyGetIt;
  final ValueChanged<String> onDropDownValueChoose;

  @override
  Widget build(BuildContext context) {
    bool firstTime = true;
    final dropdownBloc = BlocProvider.of<DropDownBloc>(context);
    return BlocBuilder<DropDownBloc, DropdownBlocState>(
      builder: (context, state) {
        return FutureBuilder<List<dynamic>>(
          future: getFutureList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Ошибка загрузки данных');
            } else {
              List<String> refKeyList = snapshot.data![0];
              List<String> companyName = snapshot.data![1];
              print('refKeyList: $refKeyList');
              print('companyName: $companyName');
              String selectedValue = state.selectedValue;
              firstTime
                  ? {
                      onDropDownValueChoose(companyName.first),
                      onRefKeyGetIt(refKeyList.first)
                    }
                  : {};

              return DropdownButton<String>(
                value: state.selectedValue.isEmpty
                    ? companyName.first
                    : selectedValue,
                isExpanded: true,
                items: companyName.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null && newValue != state.selectedValue) {
                    dropdownBloc.add(ValueWasChange(newValue: newValue));
                    firstTime = false;
                    onRefKeyGetIt(refKeyList[companyName
                        .indexWhere((element) => element == newValue)]);
                    onDropDownValueChoose(newValue);
                  }
                },
              );
            }
          },
        );
      },
    );
  }
}
