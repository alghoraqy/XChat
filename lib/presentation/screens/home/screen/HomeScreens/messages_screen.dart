import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_strings.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/assets_manager.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/components/message_screen_comp.dart';
import 'package:xchat/presentation/components/text_form_field.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

import '../../cubit/app_cubit.dart';

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
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.white,
            title: Text(
              AppStrings.messages,
              style: AppTextStyle.title,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).closeApp(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Column(
            children: [
              Container(
                height: rhight(context) / 10,
                width: rwidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
              Expanded(
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: rwidth(context) / 30),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageComponent(
                      model: cubit.messages[index],
                      onPressed: () {},
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: rhight(context) / 80,
                    );
                  },
                  itemCount: cubit.messages.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
