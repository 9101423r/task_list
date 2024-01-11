part of 'get_list_bloc.dart';

sealed class GetListEvent extends Equatable {
  const GetListEvent();

  @override
  List<Object> get props => [];
}

class GetListEventInitial extends GetListEvent {}

class ChangeValue extends GetListEvent {
  final String selectedValue;
  const ChangeValue({required this.selectedValue});
}
