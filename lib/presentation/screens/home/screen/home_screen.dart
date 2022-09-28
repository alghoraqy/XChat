import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/screens/home/cubit/app_cubit.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).closeApp(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            body: cubit.screens[cubit.startIndex],
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Icon(
                  Icons.people_alt_outlined,
                  size: 30,
                  color: cubit.startIndex == 0 ? Colors.black : Colors.white,
                ),
                Icon(
                  Icons.message_outlined,
                  size: 30,
                  color: cubit.startIndex == 1 ? Colors.black : Colors.white,
                ),
                Icon(
                  Icons.person_2_outlined,
                  size: 30,
                  color: cubit.startIndex == 2 ? Colors.black : Colors.white,
                ),
              ],
              height: rhight(context) / 14,
              index: cubit.startIndex,
              onTap: (value) {
                cubit.changeBottomNav(value);
              },
              color: AppColors.baseColor,
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.white,
              animationDuration: const Duration(milliseconds: 200),
            ),
          );
        },
      ),
    );
  }
}
