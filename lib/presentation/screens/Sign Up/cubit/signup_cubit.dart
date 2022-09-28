import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/models/user_model.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUp({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      createUser(
        userName: userName,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      debugPrint('SignUp error :${error.toString()}');
      if (error is FirebaseAuthException) {
        debugPrint(error.message!);
        emit(SignUpErrorState(message: error.message!));
      }
      emit(SignUpErrorState(message: error.toString()));
    });
  }

  void createUser({
    required String userName,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model =
        UserModel(userName: userName, email: email, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.tomap())
        .then((value) {
      emit(CreateUserSuccessState(uId: uId));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CreateUserErrorState(message: 'Create error :${error.toString()}'));
    });
  }
}
