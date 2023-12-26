import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBlocBloc extends Bloc<SignInBlocEvent, SignInBlocState> {
  SignInBlocBloc() : super(SignInBlocInitial()) {
    on<SignInBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
