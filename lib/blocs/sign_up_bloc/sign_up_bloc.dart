import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const SignUpInitial(signIsSuccses: false)) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpProcess(signIsSuccses: false));
      try {
        Future.delayed(const Duration(seconds: 5));
        const Duration(seconds: 5);
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(const SignUpSuccess(signIsSuccses: true));
      } catch (e) {
        emit(const SignUpFailure(signIsSuccses: false));
      }
      // TODO: implement event handler
    });
  }
}
