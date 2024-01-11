part of 'get_list_bloc.dart';

class GetListState extends Equatable {
  const GetListState();

  @override
  List<Object> get props => [];
}

class GetListSuccess extends GetListState {
  final String selectedValue;
  final List<String> companyList;
  const GetListSuccess(
      {required this.selectedValue, required this.companyList});
}

class GetListFailure extends GetListState {
  final String errorMsg;
  const GetListFailure({required this.errorMsg});
}

class GetListProcess extends GetListState {}
