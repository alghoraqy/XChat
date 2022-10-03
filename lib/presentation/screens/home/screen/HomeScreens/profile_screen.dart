import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/core_component.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/components/button.dart';
import 'package:xchat/presentation/components/message_screen_comp.dart';
import 'package:xchat/presentation/components/profile_screen_comp.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_textstyle.dart';
import '../../cubit/app_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent),
              backgroundColor: Colors.white,
              title: Text(
                AppStrings.profile,
                style: AppTextStyle.title,
              ),
              elevation: 0,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: rwidth(context) / 80),
                  child: TextButton(
                    onPressed: () {
                      myDialog(context,
                          myChild: Container(
                            height: rhight(context) / 3.5,
                            width: rwidth(context) / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            clipBehavior: Clip.antiAlias,
                            child: Scaffold(
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: rwidth(context) / 15,
                                        vertical: rhight(context) / 50),
                                    child: Text(
                                      AppStrings.logOut,
                                      style: AppTextStyle.messageTitle,
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: rwidth(context),
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: rwidth(context) / 10,
                                        vertical: rhight(context) / 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            AppStrings.confirmLogout,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.messageTitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyButton(
                                          child: const Text(
                                            'Yes',
                                            style: AppTextStyle.buttonStyle,
                                          ),
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .logOut(context);
                                          },
                                          hight: rhight(context) / 20,
                                          width: rwidth(context) / 4),
                                      SizedBox(
                                        width: rwidth(context) / 4,
                                        child: MaterialButton(
                                          height: rhight(context) / 20,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Text(
                                            'No',
                                            style: AppTextStyle.buttonStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                    child: Row(
                      children: [
                        Text(
                          AppStrings.logOut,
                          style: AppTextStyle.messageTitle.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: FadeInRight(
              duration: const Duration(milliseconds: 400),
              child: Column(
                children: [
                  SizedBox(
                    height: rhight(context) / 4,
                    width: rwidth(context),
                    child: Column(
                      children: [
                        CircleImage(
                          image:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rsSzLimlQyniEtUV4-1raljzFhS45QBeAw&usqp=CAU',
                          hight: rhight(context) / 4,
                          width: rwidth(context) / 2.2,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: rwidth(context),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: AppColors.backgroundColor),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: rwidth(context) / 20,
                              vertical: rhight(context) / 40),
                          child: Column(
                            children: [
                              ProfileData(text: 'Mahmoud Alghoraqy sad'),
                              SizedBox(
                                height: rhight(context) / 50,
                              ),
                              ProfileData(text: 'Mahmoud Alghoraqy sad'),
                              SizedBox(
                                height: rhight(context) / 50,
                              ),
                              ProfileData(text: 'Mahmoud Alghoraqy sad'),
                              SizedBox(
                                height: rhight(context) / 50,
                              ),
                              ProfileData(text: 'Mahmoud Alghoraqy sad'),
                              SizedBox(
                                height: rhight(context) / 50,
                              ),
                              SizedBox(
                                height: rhight(context) / 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.5),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(4, 3))
                                    ]),
                                child: MyButton(
                                  child: const Text(
                                    'Edit Profile',
                                    style: AppTextStyle.buttonStyle,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        clipBehavior: Clip.antiAlias,
                                        context: context,
                                        builder: (context) {
                                          return FadeInUp(
                                            child: Container(
                                              height: rhight(context) / 1.1,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: rhight(context) / 4,
                                                    width: rwidth(context),
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: [
                                                        ProfileStack()
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: rwidth(context),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          40),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          40)),
                                                          color: AppColors
                                                              .backgroundColor),
                                                      child:
                                                          SingleChildScrollView(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: rwidth(
                                                                      context) /
                                                                  20,
                                                              vertical: rhight(
                                                                      context) /
                                                                  40),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: Column(
                                                              children: [
                                                                const ProfileFormField(
                                                                  hint:
                                                                      'User Name',
                                                                ),
                                                                SizedBox(
                                                                  height: rhight(
                                                                          context) /
                                                                      40,
                                                                ),
                                                                const ProfileFormField(
                                                                  hint: 'Email',
                                                                ),
                                                                SizedBox(
                                                                  height: rhight(
                                                                          context) /
                                                                      40,
                                                                ),
                                                                const ProfileFormField(
                                                                  hint: 'Phone',
                                                                ),
                                                                SizedBox(
                                                                  height: rhight(
                                                                          context) /
                                                                      40,
                                                                ),
                                                                const ProfileFormField(
                                                                  hint:
                                                                      'Password',
                                                                ),
                                                                SizedBox(
                                                                  height: rhight(
                                                                          context) /
                                                                      20,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Colors
                                                                          .white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors.black.withOpacity(
                                                                                .5),
                                                                            blurRadius:
                                                                                5,
                                                                            spreadRadius:
                                                                                1,
                                                                            offset:
                                                                                const Offset(4, 3))
                                                                      ]),
                                                                  child: MyButton(
                                                                      child: const Text(
                                                                        'Save',
                                                                        style: AppTextStyle
                                                                            .buttonStyle,
                                                                      ),
                                                                      onPressed: () {},
                                                                      hight: rhight(context) / 14,
                                                                      width: rwidth(context) / 1.5),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  hight: rhight(context) / 14,
                                  width: rwidth(context) / 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
