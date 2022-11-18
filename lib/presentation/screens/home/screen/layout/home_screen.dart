import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/screens/home/cubit/app_cubit.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserProfile()
        ..checkInternet(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Builder(
            builder: (context) {
              cubit.getAllUsers();
              return Scaffold(
                backgroundColor: Colors.white,
                body: cubit.connectionState
                    ? cubit.screens[cubit.startIndex]
                    : Scaffold(
                        backgroundColor: AppColors.backgroundColor,
                        body: Center(
                          child: Lottie.asset('assets/lottie/noInternet.json'),
                        )),
                bottomNavigationBar: CurvedNavigationBar(
                  items: [
                    FaIcon(
                      FontAwesomeIcons.users,
                      size: 25,
                      color:
                          cubit.startIndex == 0 ? Colors.black : Colors.white,
                    ),
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 25,
                      color:
                          cubit.startIndex == 1 ? Colors.black : Colors.white,
                    ),
                    FaIcon(
                      FontAwesomeIcons.userTie,
                      size: 25,
                      color:
                          cubit.startIndex == 2 ? Colors.black : Colors.white,
                    ),
                  ],
                  height: rhight(context) / 14,
                  index: cubit.startIndex,
                  onTap: (value) {
                    cubit.changeBottomNav(value);
                  },
                  color: AppColors.baseColor,
                  backgroundColor: Colors.blue.shade50,
                  buttonBackgroundColor: Colors.transparent,
                  animationDuration: const Duration(milliseconds: 200),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
