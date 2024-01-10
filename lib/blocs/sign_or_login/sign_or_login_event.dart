part of 'sign_or_login_bloc.dart';

sealed class SignOrLoginEvent extends Equatable {
  const SignOrLoginEvent();

  @override
  List<Object> get props => [];
}


class JustSwipe extends SignOrLoginEvent{
  final bool swipePage;

  const JustSwipe({required this.swipePage});
}
