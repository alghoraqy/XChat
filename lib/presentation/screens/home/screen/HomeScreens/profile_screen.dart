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
              leadingWidth: 0,
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
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .logOut(context);
                                          },
                                          hight: rhight(context) / 20,
                                          width: rwidth(context) / 4,
                                          child: const Text(
                                            'Yes',
                                            style: AppTextStyle.buttonStyle,
                                          )),
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
            body: cubit.userProfile != null
                ? FadeInRight(
                    duration: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        SizedBox(
                          height: rhight(context) / 4,
                          width: rwidth(context),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left:2),
                                height: rhight(context) / 4,
                                width: rwidth(context) / 2.2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:Image(image: NetworkImage(cubit.userProfile!.image), 
                                fit: BoxFit.cover,
                                ),
                              ),
                              // cubit.profileImage == null
                              //     ? CircleImage(
                              //         image: NetworkImage(
                              //           cubit.userProfile!.image,
                              //         ),
                              //         hight: rhight(context) / 4,
                              //         width: rwidth(context) / 2.2,
                              //       )
                              //     : Container(
                              //         margin: EdgeInsets.only(left: 2),
                              //         height: rhight(context) / 4,
                              //         width: rwidth(context) / 2.2,
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //         ),
                              //         clipBehavior: Clip.antiAlias,
                              //         child: Image(
                              //           image: FileImage(cubit.profileImage!),
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
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
                                    ProfileData(
                                        text: cubit.userProfile!.userName),
                                    SizedBox(
                                      height: rhight(context) / 50,
                                    ),
                                    ProfileData(text: cubit.userProfile!.email),
                                    SizedBox(
                                      height: rhight(context) / 50,
                                    ),
                                    ProfileData(text: cubit.userProfile!.phone),
                                    SizedBox(
                                      height: rhight(context) / 7,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.5),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: const Offset(4, 3))
                                          ]),
                                      child: MyButton(
                                        onPressed: () {
                                          cubit.profileImage =null;
                                          cubit.userNameController.text =
                                              cubit.userProfile!.userName;
                                          cubit.emailController.text =
                                              cubit.userProfile!.email;
                                          cubit.phoneController.text =
                                              cubit.userProfile!.phone;
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                              clipBehavior: Clip.antiAlias,
                                              context: context,
                                              builder: (_) {
                                                return BlocProvider.value(
                                                  value: AppCubit.get(context),
                                                  child: BlocConsumer<AppCubit,
                                                      AppStates>(
                                                    listener:
                                                        (context, state) {},
                                                    builder: (context, state) {
                                                      AppCubit cubit2 =
                                                          AppCubit.get(context);
                                                      return FadeInUp(
                                                        child: Container(
                                                          height:
                                                              rhight(context) /
                                                                  1.1,
                                                          color: Colors.white,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: rhight(
                                                                        context) /
                                                                    4,
                                                                width: rwidth(
                                                                    context),
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  children: [
                                                                    cubit2.profileImage ==
                                                                            null
                                                                        ? ProfileStack(
                                                                            image:
                                                                                NetworkImage(cubit2.userProfile!.image),
                                                                            onPressed:
                                                                                () {
                                                                              cubit2.pickProfileImage();
                                                                            },
                                                                          )
                                                                        : ProfileStack(
                                                                            image:
                                                                                FileImage(cubit2.profileImage!),
                                                                            onPressed:
                                                                                () {
                                                                              cubit2.pickProfileImage();
                                                                            },
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  width: rwidth(
                                                                      context),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              40),
                                                                          topRight: Radius.circular(
                                                                              40)),
                                                                      color: AppColors
                                                                          .backgroundColor),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    physics:
                                                                        const BouncingScrollPhysics(),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: rwidth(context) /
                                                                              20,
                                                                          vertical:
                                                                              rhight(context) / 40),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            ProfileFormField(
                                                                              hint: 'User Name',
                                                                              controller: cubit2.userNameController,
                                                                            ),
                                                                            SizedBox(
                                                                              height: rhight(context) / 40,
                                                                            ),
                                                                            ProfileFormField(
                                                                              hint: 'Email',
                                                                              controller: cubit2.emailController,
                                                                            ),
                                                                            SizedBox(
                                                                              height: rhight(context) / 40,
                                                                            ),
                                                                            ProfileFormField(
                                                                              hint: 'Phone',
                                                                              controller: cubit2.phoneController,
                                                                            ),
                                                                            SizedBox(
                                                                              height: rhight(context) / 40,
                                                                            ),
                                                                            ProfileFormField(
                                                                              hint: 'Password',
                                                                              controller: cubit2.passwordController,
                                                                            ),
                                                                            SizedBox(
                                                                              height: rhight(context) / 20,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, boxShadow: [
                                                                                BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 5, spreadRadius: 1, offset: const Offset(4, 3))
                                                                              ]),
                                                                              child: MyButton(
                                                                                  onPressed: () {
                                                                                    cubit.load = false;
                                                                                    cubit.updateUser(context);
                                                                                  },
                                                                                  hight: rhight(context) / 14,
                                                                                  width: rwidth(context) / 1.5,
                                                                                  child:cubit.load == false
                                                                                      ? Center(
                                                                                          child: CircularProgressIndicator(color: Colors.white),
                                                                                        )
                                                                                      : Text(
                                                                                          'Save',
                                                                                          style: AppTextStyle.buttonStyle,
                                                                                        )),
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
                                                    },
                                                  ),
                                                );
                                              });
                                        },
                                        hight: rhight(context) / 14,
                                        width: rwidth(context) / 1.5,
                                        child: const Text(
                                          'Edit Profile',
                                          style: AppTextStyle.buttonStyle,
                                        ),
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
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.baseColor,
                    ),
                  ));
      },
    );
  }
}
