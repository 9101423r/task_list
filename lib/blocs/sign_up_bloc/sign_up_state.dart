part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  final bool signIsSuccses;
  const SignUpState({required this.signIsSuccses});

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial({required super.signIsSuccses});
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({required super.signIsSuccses});
}

class SignUpFailure extends SignUpState {
  const SignUpFailure({required super.signIsSuccses});
}

class SignUpProcess extends SignUpState {
  const SignUpProcess({required super.signIsSuccses});
}
