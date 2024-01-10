import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/domain/auth/auth_data.dart';


part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInBlocInitial()) {
    on<SignInRequired>((event, emit)async {
       emit(const SignInProcess());
      try{
        await Authentication().login(event.email,event.password);
        emit(const SignInSuccess());
      }
      catch (e){
        emit(const SignInFailure());
        print(e);
      }
      
    });
    on<SwipeWithAnotherPage>(((event, emit) {
    Navigator.pushReplacementNamed(event.context,'/login_screen');
     }));
  
  }
}
