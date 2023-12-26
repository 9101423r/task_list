part of 'fake_authentication_bloc.dart';

enum FakeAuthenticationStatus { authenticated, unauthenticated, unknown }

class FakeAuthenticationState extends Equatable {
  const FakeAuthenticationState._(
      {this.status = FakeAuthenticationStatus.unknown, this.fakeUser});

  const FakeAuthenticationState.unknown() : this._();
  const FakeAuthenticationState.authenticated(FakeUser fakeUser)
      : this._(
            status: FakeAuthenticationStatus.authenticated, fakeUser: fakeUser);

  const FakeAuthenticationState.unauthenticated()
      : this._(status: FakeAuthenticationStatus.unauthenticated);
  final FakeAuthenticationStatus status;
  final FakeUser? fakeUser;

  @override
  List<Object?> get props => [status, fakeUser];
}
