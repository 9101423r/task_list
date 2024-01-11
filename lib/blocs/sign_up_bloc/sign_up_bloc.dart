import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list/domain/auth/auth_data.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpProcess());
      try {
        Future.delayed(const Duration(seconds: 5));
        const Duration(seconds: 5);
        MyUser user = await Authentication().signUp(event.user, event.password);
        await FirebaseUserAuth().createUser(user);
        emit(const SignUpSuccess());
      } catch (e) {
        emit(const SignUpFailure());
      }
    });
    on<GetListCompanyName>((event, emit) {});
  }
}
