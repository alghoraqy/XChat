import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';
import 'package:xchat/presentation/screens/home/screen/HomeScreens/messages_screen.dart';
import 'package:xchat/presentation/screens/home/screen/HomeScreens/profile_screen.dart';
import 'package:xchat/presentation/screens/home/screen/HomeScreens/users_screens.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/network/local/cach_helper.dart';
import '../../../../core/utils/shared_methods.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  void closeApp(context) {
    ClearDataFromPrefs.clearData().then((value) {
      navigateAndFinish(context, Routes.initialRoute);
      emit(ChangeState());
    });
  }

  // List<Widget> navItems = [
  //   Icon(
  //     Icons.people_alt_outlined,
  //     size: 30,
  //     color: startIndex == 0 ? Colors.black : Colors.white,
  //   ),
  //   Icon(
  //     Icons.message_outlined,
  //     size: 30,
  //     color: startIndex == 1 ? Colors.black : Colors.white,
  //   ),
  //   Icon(
  //     Icons.person_2_outlined,
  //     size: 30,
  //     color: startIndex == 2 ? Colors.black : Colors.white,
  //   ),
  // ];
  int startIndex = 1;
  void changeBottomNav(int index) {
    emit(AppInitState());
    startIndex = index;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    const UsersScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];
}
