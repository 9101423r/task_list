import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list/data/auth/auth_data.dart';
import 'package:task_list/data/auth/firebase_auth.dart';
import 'package:task_list/data/auth/firebase_notification.dart';
import 'package:task_list/domain/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // Блок для создание пользователя
  SignUpBloc() : super(const SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpProcess());
      try {
        String fCMToken = await FirebaseNotification().initNotification();
        print('fCMToken for task Bloc : $fCMToken');
        MyUser createUser = MyUser.empty;

        createUser = MyUser(
            userId: event.userID,
            email: event.userLogin,
            companyName: event.userCompanyName,
            phoneNumber: event.userPhoneNumber,
            fullName: event.userName,
            refKey: event.refkey,
            fcmToken: fCMToken);

        MyUser user = await Authentication().signUp(
            createUser, event.password); // this user return firebase user uid
        await FirebaseUserAuth().createUser(user);
        emit(const SignUpSuccess());
      } catch (e) {
        emit(const SignUpFailure());
      }
    });
  }
}
