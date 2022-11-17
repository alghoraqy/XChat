import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/components/message_screen_comp.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

import '../../cubit/app_cubit.dart';
import 'details_of_message.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            leadingWidth: 0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.white,
            title: Text(
              AppStrings.messages,
              style: AppTextStyle.title,
            ),
            elevation: 0,
          ),
          body: Column(
            children: [
              Container(
                height: rhight(context) / 10,
                width: rwidth(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: rwidth(context) / 1.2,
                      height: rhight(context) / 19,
                      child: const SearchComponent(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: rhight(context) / 50,
              ),
              cubit.searchedUsers.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: rhight(context) / 8),
                        child: Center(
                          child: Lottie.asset('assets/lottie/search.json',
                              height: rhight(context) / 2.05,
                              fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : Expanded(
                      child: AnimationLimiter(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: rwidth(context) / 30),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: MyMessageComponent(
                                    model: cubit.searchedUsers[index],
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return BlocProvider.value(
                                            value: AppCubit.get(context),
                                            child: DetailsOfMessage(
                                                userModel: cubit
                                                    .searchedUsers[index]));
                                      }));
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: rhight(context) / 80,
                            );
                          },
                          itemCount: cubit.searchedUsers.length,
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
