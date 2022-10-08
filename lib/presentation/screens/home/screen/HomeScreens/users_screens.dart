import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/assets_manager.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/main.dart';
import 'package:xchat/presentation/components/message_screen_comp.dart';
import 'package:xchat/presentation/components/users_screen_comp.dart';
import 'package:xchat/presentation/screens/home/cubit/app_cubit.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_textstyle.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.white,
            centerTitle: true,
            leadingWidth: rwidth(context) / 5,
            leading: Padding(
              padding: EdgeInsets.only(left: rwidth(context) / 100),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage(
                  placeholder: AssetImage(ImgAsset.loading),
                  placeholderFit: BoxFit.cover,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rsSzLimlQyniEtUV4-1raljzFhS45QBeAw&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              AppStrings.people,
              style: AppTextStyle.title,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Column(
            children: [
              Container(
                height: rhight(context) / 25,
                width: rwidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Colors.white),
              ),
              SizedBox(
                height: rhight(context) / 50,
              ),
              cubit.allUsers.isNotEmpty
                  ? Expanded(
                      child: AnimationLimiter(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: rwidth(context) / 30),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: AllUsersComponent(
                                      userModel: cubit.allUsers[index],
                                      onPressed: () {}),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: rhight(context) / 80,
                            );
                          },
                          itemCount: cubit.allUsers.length,
                        ),
                      ),
                    )
                  : Center(
                      child:
                          CircularProgressIndicator(color: AppColors.baseColor),
                    ),
            ],
          ),
        );
      },
    );
  }
}
