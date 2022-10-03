import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/config/routes/app_routes.dart';
import 'package:xchat/core/network/local/cach_helper.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/core/utils/shared_methods.dart';
import 'package:xchat/presentation/components/button.dart';
import 'package:xchat/presentation/components/text_form_field.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_cubit.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_states.dart';
import 'package:xchat/presentation/screens/Sign%20Up/screen/choose_picture_screen.dart';

import '../../../../core/utils/constances.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
            showToast(message: state.message, color: Colors.red);
          } else if (state is CreateUserSuccessState) {
            SaveDataToPrefs.saveData(key: 'uId', value: state.uId)
                .then((value) {
              Constances.uId = state.uId;
              showToast(
                  message: 'User Created Successfully', color: Colors.green);
              // navigateTo(context, Routes.choosePicture);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: SignUpCubit.get(context),
                            child: const ChoosePictureScreen(),
                          )));
            });
          } else {
            if (state is CreateUserErrorState) {
              showToast(message: state.message, color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          SignUpCubit cubit = SignUpCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: rwidth(context) / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppStrings.signUp},',
                      style: AppTextStyle.textAppNamestyle
                          .copyWith(color: Colors.black, fontSize: 35),
                    ),
                    SizedBox(
                      height: rhight(context) / 60,
                    ),
                    Text(
                      AppStrings.signUptext,
                      style: AppTextStyle.onBoardingText2
                          .copyWith(color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      height: rhight(context) / 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: rhight(context) / 80),
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              children: [
                                MyTextFormField(
                                  labeltext: 'User Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'user name must not be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  controller: cubit.userNameController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 40,
                                ),
                                MyTextFormField(
                                  labeltext: 'E-mail address',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email must not be empty';
                                    } else {
                                      if (value.contains('@') == false) {
                                        return ' Please Enter a valid email';
                                      }
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: cubit.emailController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 40,
                                ),
                                MyTextFormField(
                                  labeltext: 'Phone',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'phone must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: cubit.phoneController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 40,
                                ),
                                MyTextFormField(
                                  labeltext: 'Password',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password must not be empty';
                                    } else {
                                      if (value.length < 6) {
                                        return 'password must be more than 6 char, please enter a valid Password';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  isSecure: true,
                                  controller: cubit.passwordController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 40,
                                ),
                                MyTextFormField(
                                  labeltext: 'Confirm Password',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Confirm passord must not be empty';
                                    } else {
                                      if (value !=
                                          cubit.passwordController.text) {
                                        return 'Not Equal Password';
                                      }
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  isSecure: true,
                                  controller: cubit.confirmPasswordController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 20,
                                ),
                                MyButton(
                                  child: state is SignUpLoadingState
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          AppStrings.signUp,
                                          style: AppTextStyle.buttonStyle,
                                        ),
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.signUp(
                                          userName:
                                              cubit.userNameController.text,
                                          email: cubit.emailController.text,
                                          password:
                                              cubit.passwordController.text,
                                          phone: cubit.phoneController.text);
                                    }
                                  },
                                  hight: rhight(context) / 14,
                                  width: rwidth(context) / 1.2,
                                ),
                                SizedBox(
                                  height: rhight(context) / 80,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: rwidth(context) / 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Have an account?',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.onBoardingText2
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateAndFinish(
                                              context, Routes.loginScreen);
                                        },
                                        child: Text(
                                          AppStrings.loginNow,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.onBoardingText
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
