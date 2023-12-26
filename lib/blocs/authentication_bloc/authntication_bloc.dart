import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'authntication_event.dart';
part 'authntication_state.dart';

class AuthenticationBloc extends Bloc<AuthnticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> userSubscription;

  AuthenticationBloc({required this.userRepository})
      : super(const AuthenticationState.unknown()) {
    userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user)); // TODO Check 53:51 user?
    });

    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }
  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
