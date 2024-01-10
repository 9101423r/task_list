part of 'sign_or_login_bloc.dart';

class SignOrLoginState extends Equatable {

  
  const SignOrLoginState();

  
  @override
  List<Object> get props => [];
}


class SignOrLoginInitial extends SignOrLoginState{
   
  const SignOrLoginInitial();
}


class Login extends SignOrLoginState{

}

class Sign extends SignOrLoginState{

}