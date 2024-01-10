part of 'authntication_bloc.dart';

sealed class AuthnticationEvent extends Equatable {
  const AuthnticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthnticationEvent {
  final User? user;
  const AuthenticationUserChanged(this.user);
}


