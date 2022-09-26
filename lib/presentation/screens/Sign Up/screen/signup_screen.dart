import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/config/routes/app_routes.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/core/utils/shared_methods.dart';
import 'package:xchat/presentation/components/button.dart';
import 'package:xchat/presentation/components/text_form_field.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_cubit.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_states.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: BlocProvider(
                    create: (context) => SignUpCubit(),
                    child: BlocConsumer<SignUpCubit, SignUpStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        SignUpCubit cubit = SignUpCubit.get(context);
                        return Form(
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
                                keyboardType: TextInputType.name,
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
                              ),
                              SizedBox(
                                height: rhight(context) / 40,
                              ),
                              MyTextFormField(
                                labeltext: 'Confirm Passord',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Confirm passord must not be empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(
                                height: rhight(context) / 20,
                              ),
                              MyButton(
                                child: Text(
                                  AppStrings.signUp,
                                  style: AppTextStyle.buttonStyle,
                                ),
                                onPressed: () {},
                                hight: rhight(context) / 14,
                                width: rwidth(context) / 1.2,
                              ),
                              SizedBox(
                                height: rhight(context) / 30,
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
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
