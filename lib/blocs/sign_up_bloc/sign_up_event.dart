part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final String userID;
  final String userName;
  final String userLogin;
  final String userCompanyName;
  final String refkey;
  final String userPhoneNumber;

  final String password;

  const SignUpRequired(
      {required this.userID,
        required this.userName,
      required this.userLogin,
      required this.userCompanyName,
      required this.refkey,
      required this.userPhoneNumber,
      required this.password});
}
