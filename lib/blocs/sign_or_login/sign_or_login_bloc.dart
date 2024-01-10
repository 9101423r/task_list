import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_or_login_event.dart';
part 'sign_or_login_state.dart';

class SignOrLoginBloc extends Bloc<SignOrLoginEvent, SignOrLoginState> {
  SignOrLoginBloc() : super(const SignOrLoginInitial()) 
  {
    on<JustSwipe>((event, emit) {
      
      

      event.swipePage? emit(Sign()): emit(Login());

    });
  }
}
