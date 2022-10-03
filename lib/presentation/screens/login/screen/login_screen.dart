import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/config/routes/app_routes.dart';
import 'package:xchat/core/network/local/cach_helper.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/constances.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/core/utils/shared_methods.dart';
import 'package:xchat/presentation/components/components.dart';
import 'package:xchat/presentation/components/text_form_field.dart';
import 'package:xchat/presentation/screens/login/cubit/login_cubit.dart';
import 'package:xchat/presentation/screens/login/cubit/login_states.dart';

import '../../../components/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: AppColors.baseColor,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColors.baseColor),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          LoginComponent(),
          BlocProvider(
            create: (BuildContext context) {
              return LoginCubit();
            },
            child: BlocConsumer<LoginCubit, LoginStates>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  SaveDataToPrefs.saveData(key: 'uId', value: state.uId)
                      .then((value) {
                    Constances.uId = state.uId;
                    print(Constances.uId);
                    showToast(message: 'Login Success', color: Colors.green);
                    navigateAndFinish(context, Routes.homeScreen);
                  });
                } else {
                  if (state is LoginErrorState) {
                    showToast(message: state.message, color: Colors.red);
                  }
                }
              },
              builder: (context, state) {
                LoginCubit cubit = LoginCubit.get(context);
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          AppStrings.hi,
                          style: AppTextStyle.textAppNamestyle
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppStrings.loginText,
                          style: AppTextStyle.onBoardingText2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: rhight(context) / 15,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: rwidth(context) / 13),
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              children: [
                                MyTextFormField(
                                  labeltext: AppStrings.email,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email must not be empty';
                                    } else {
                                      if (value.contains('@') == false) {
                                        return 'Enter a valid email';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: cubit.emailController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 50,
                                ),
                                MyTextFormField(
                                  labeltext: AppStrings.password,
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
                                  isSecure: cubit.isSecure,
                                  keyboardType: TextInputType.visiblePassword,
                                  suffix: IconButton(
                                    onPressed: () {
                                      cubit.changeSecure();
                                    },
                                    icon: Icon(
                                      cubit.isSecure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.baseColor,
                                    ),
                                  ),
                                  controller: cubit.passwordController,
                                ),
                                SizedBox(
                                  height: rhight(context) / 20,
                                ),
                                MyButton(
                                  child: state is LoginLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          AppStrings.login,
                                          style: AppTextStyle.buttonStyle,
                                        ),
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.login(
                                          email: cubit.emailController.text,
                                          password:
                                              cubit.passwordController.text);
                                    }
                                  },
                                  hight: rhight(context) / 14,
                                  width: rwidth(context) / 1.2,
                                ),
                                SizedBox(
                                  height: rhight(context) / 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'New User?',
                                      style: AppTextStyle.onBoardingText2
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        navigateAndFinish(
                                            context, Routes.signUpScreen);
                                      },
                                      child: Text(
                                        AppStrings.registerNow,
                                        style: AppTextStyle.onBoardingText
                                            .copyWith(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
