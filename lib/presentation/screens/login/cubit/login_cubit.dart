import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/presentation/screens/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;
  void changeSecure() {
    emit(LoginInitState());
    isSecure = !isSecure;
    emit(LoginChangeSecure());
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        emit(LoginErrorState(message: error.message!));
      }
      debugPrint(error.toString());
      emit(LoginErrorState(message: error.toString()));
    });
  }
}
