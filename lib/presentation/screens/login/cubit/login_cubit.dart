import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/presentation/screens/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  bool isSecure = false;
  void changeSecure() {
    isSecure = !isSecure;
    emit(LoginChangeSecure());
  }
}
