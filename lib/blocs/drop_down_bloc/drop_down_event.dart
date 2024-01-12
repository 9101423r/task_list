part of 'drop_down_bloc.dart';

sealed class DropDownEvent extends Equatable {
  const DropDownEvent();

  @override
  List<Object> get props => [];
}

class ValueWasChange extends DropDownEvent {
  final String newValue;

  const ValueWasChange({required this.newValue});
}
