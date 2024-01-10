part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;
  

  const SignUpRequired(this.user, this.password);
}

class GetListCompanyName extends SignUpEvent{
  final String selectedItem;
  const GetListCompanyName({required this.selectedItem});
}
