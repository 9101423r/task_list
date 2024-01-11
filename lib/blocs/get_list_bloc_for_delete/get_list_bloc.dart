import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list/domain/api/list_compain.dart';

part 'get_list_event.dart';
part 'get_list_state.dart';

class GetListBloc extends Bloc<GetListEvent, GetListState> {
  bool isItFirstTime = true;
  late String selectedValue;
  GetListBloc() : super(GetListProcess()) {
    on<GetListEventInitial>((event, emit) async {
      emit(GetListProcess());
      late List<String> companyList;
      companyList = await ApiFromServer().getListCompany();
      print('Company name: $companyList');
      if (companyList.isNotEmpty) {
        if (isItFirstTime) {
          selectedValue = companyList.first;
          isItFirstTime = !isItFirstTime;
        } else {
          on<ChangeValue>((event, emit) {});
        }
        emit(GetListSuccess(selectedValue: '', companyList: companyList));
      } else {
        emit(const GetListFailure(errorMsg: 'Please refresh page'));
      }
    });
  }
}
