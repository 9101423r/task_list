import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drop_down_event.dart';
part 'drop_down_state.dart';

class DropDownBloc extends Bloc<DropDownEvent, DropdownBlocState> {
  DropDownBloc() : super(DropdownBlocState(selectedValue: ''))
  {
    on<ValueWasChange>((event, emit) {
      emit(DropdownBlocState(selectedValue: event.newValue));
    } );
  }

  // Stream<DropdownBlocState> mapEventToState(ValueWasChange event) async* {
  //
  //     yield DropdownBlocState(selectedValue: event.newValue);
  //
  // }
}
