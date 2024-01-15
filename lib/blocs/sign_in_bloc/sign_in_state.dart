part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInBlocInitial extends SignInState {}

class SignInSuccess extends SignInState {
  const SignInSuccess();
}

class SignInFailure extends SignInState {
  final String firebaseException;
  const SignInFailure({required this.firebaseException});
}

class SignInProcess extends SignInState {
  const SignInProcess();
}