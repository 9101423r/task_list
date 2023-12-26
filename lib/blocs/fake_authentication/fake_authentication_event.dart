part of 'fake_authentication_bloc.dart';

sealed class FakeAuthenticationEvent extends Equatable {
  const FakeAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class FakeAuthenticationLoginPressed extends FakeAuthenticationEvent {
  final FakeUser user;
  const FakeAuthenticationLoginPressed(this.user);
}
