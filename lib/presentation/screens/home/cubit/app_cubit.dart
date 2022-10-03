import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/models/message_model.dart';
import 'package:xchat/models/user_model.dart';
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

  void logOut(context) {
    ClearDataFromPrefs.clearData().then((value) {
      emit(AppInitState());
      navigateAndFinish(context, Routes.initialRoute);
      emit(ChangeState());
    });
  }

  TextEditingController searchController = TextEditingController();

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

  List<MessageModel> messages = [
    MessageModel(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rsSzLimlQyniEtUV4-1raljzFhS45QBeAw&usqp=CAU',
      name: 'mahmoud elsayed',
      messageBody: 'asssssssssda asdasd asdasd asda',
      lastDate: '5 days',
    ),
    MessageModel(
      image:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      name: 'marwa mohamed',
      messageBody: 'asdasd dasdas asda',
      lastDate: '18 days',
    ),
    MessageModel(
      image:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      name: 'ahmed mohamed',
      messageBody: 'asddddddddasd asdasd ',
      lastDate: '10 days',
    ),
    MessageModel(
      image:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      name: 'ahmed mohamed',
      messageBody: 'asddddddddasd asdasd ',
      lastDate: '10 days',
    ),
  ];

  List<PeopleModel> people = [
    PeopleModel(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4rsSzLimlQyniEtUV4-1raljzFhS45QBeAw&usqp=CAU',
        name: 'Mahmoud Alghoraqy'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
    PeopleModel(
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        name: 'Elsayed Ahmed'),
  ];
}
