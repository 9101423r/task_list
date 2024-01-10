part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

class SignUpFailure extends SignUpState {
  const SignUpFailure();
}

class SignUpProcess extends SignUpState {
  const SignUpProcess();
}
