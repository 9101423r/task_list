import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task_list/data/auth/auth_data.dart';
import 'package:task_list/data/auth/firebase_auth.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // Блок для логина пользователя с существующим аккаунтом в FirebaseAuth
  SignInBloc() : super(SignInBlocInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(const SignInProcess());
      String result = await Authentication().login(event.email, event.password);
      Map<String, dynamic> userInfo = await FirebaseUserAuth().getUserInfo();

      await ImportantFieldsLocalStorage()
          .saveUserInfo(userInfo); // TODO check here cast()
      result == 'Success'
          ? emit(const SignInSuccess())
          : emit(SignInFailure(firebaseException: result));
    });
  }
}
