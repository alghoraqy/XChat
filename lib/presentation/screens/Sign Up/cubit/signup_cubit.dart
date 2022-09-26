import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
}
