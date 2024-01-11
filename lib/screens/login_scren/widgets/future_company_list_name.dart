// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_list/blocs/get_list_bloc/get_list_bloc.dart';

// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetListBloc, GetListState>(
//       builder: (context, state) {
//         if (state is GetListSuccess) {
//           return buildDropdownMenu(context, state.companyList);
//         } else if (state is GetListFailure) {
//           return Center(
//             child: Text(state.errorMsg),
//           );
//         } else {
//           // Handle other states or return a loading indicator
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   Widget buildDropdownMenu(BuildContext context, List<String> companyList) {
//     return DropdownButton<String>(
//       value: context.read<GetListBloc>().selectedValue,
//       onChanged: (String? newValue) {
//         context.read<GetListBloc>().add(ChangeValue(selectedValue: newValue!));
//       },
//       items: companyList.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
