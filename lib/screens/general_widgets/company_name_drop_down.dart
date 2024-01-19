import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/drop_down_bloc/drop_down_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';
import 'dart:developer' as dev;

class DropDownWithRefKeyAndChangeValue extends StatefulWidget {
  final Future<List<List<String>>> getFutureList;

  const DropDownWithRefKeyAndChangeValue(
      {required this.getFutureList,
      required this.onRefKeyGetIt,
      required this.onDropDownValueChoose,
      super.key});
  final ValueChanged<String> onRefKeyGetIt;
  final ValueChanged<String> onDropDownValueChoose;

  @override
  State<DropDownWithRefKeyAndChangeValue> createState() =>
      _DropDownWithRefKeyAndChangeValueState();
}

class _DropDownWithRefKeyAndChangeValueState
    extends State<DropDownWithRefKeyAndChangeValue> {
  // final List<List<String>>? listDynamicCrutchKeys =
  //     ImportantFieldsLocalStorage().box.values.isNotEmpty
  //         ? [
  //             ImportantFieldsLocalStorage()
  //                 .box
  //                 .get(1)!
  //                 .someImportantMaps[1]
  //                 .keys
  //                 .toList(),
  //             ImportantFieldsLocalStorage()
  //                 .box
  //                 .get(1)!
  //                 .someImportantMaps[1]
  //                 .values
  //                 .toList()
  //           ]
  //         : [];

  // Future<List<List<String>>>?
  //     definitionWhatINFutureGETAndCheckBoxValues() async {
  //   print('Check what thr list here :${listDynamicCrutchKeys}');

  //     if (ImportantFieldsLocalStorage()
  //         .box
  //         .get(1)!
  //         .someImportantMaps[1]
  //         .isNotEmpty) {
  //       return Future.value(listDynamicCrutchKeys);
  //     } else {
  //       return widget.getFutureList;
  //     }

  // }

  // // late Future<List<List<String>>>? finallyGettingFutureList;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // finallyGettingFutureList = definitionWhatINFutureGETAndCheckBoxValues();
  //   dev.log('Its initState DropDownWithRefKeyAndChangeValue');
  // }

  @override
  Widget build(BuildContext context) {
    final dropdownBloc = BlocProvider.of<DropDownBloc>(context);

    return BlocBuilder<DropDownBloc, DropdownBlocState>(
      builder: (context, state) {
        return FutureBuilder<List<List<String>>>(
          future: widget.getFutureList,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(AppLocalizations.of(context)!.refreshPageText);
            } else if (snapshot.data == null) {
              return Text(AppLocalizations.of(context)!.refreshPageText);
            } else {
              // TODO
              List<String> refKeyList = snapshot.data![0];
              List<String> companyName = snapshot.data![1];

              String selectedValue = state.selectedValue;
              state.selectedValue.isEmpty
                  ? {
                      widget.onRefKeyGetIt(refKeyList.first),
                      widget.onDropDownValueChoose(companyName.first),
                      print('refKeyList.first:${refKeyList.first}'),
                      print("companyName.first:${companyName.first}")
                    }
                  : {};

              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.selectedValue.isEmpty
                      ? companyName.first
                      : selectedValue,
                  isExpanded: true,
                  underline: const Divider(),
                  items: companyName.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null && newValue != state.selectedValue) {
                      dropdownBloc.add(ValueWasChange(newValue: newValue));

                      widget.onRefKeyGetIt(refKeyList[companyName
                          .indexWhere((element) => element == newValue)]);
                      widget.onDropDownValueChoose(newValue);
                      print('[false log]typeOfTask Task: $newValue');
                      print(
                          '[false log]  Это его ключевое представление форма :  ${refKeyList[companyName.indexWhere((element) => element == newValue)]}');
                    }
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
