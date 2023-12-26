import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task_list/fake_datas_about_user.dart';

part 'fake_authentication_event.dart';
part 'fake_authentication_state.dart';

class FakeAuthenticationBloc
    extends Bloc<FakeAuthenticationEvent, FakeAuthenticationState> {
  FakeAuthenticationBloc() : super(const FakeAuthenticationState.unknown()) {
    on<FakeAuthenticationEvent>((event, emit) {
      on<FakeAuthenticationLoginPressed>((event, emit) {
        emit(FakeAuthenticationState.authenticated(
            FakeUser(companyName: 'ALI COMPANY', email: 'ALI GMAIL COM')));
      });
    });
  }
}
