import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/constances.dart';
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

  /// LOGOUT
  void logOut(context) {
    ClearDataFromPrefs.clearData().then((value) {
      emit(AppInitState());
      navigateAndFinish(context, Routes.initialRoute);
      emit(ChangeState());
    });
  }

  TextEditingController searchController = TextEditingController();

  /// EDIT PROFILE CONTROLLERS
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// BOTTOM NAV
  int startIndex = 1;
  void changeBottomNav(int index) {
    emit(AppInitState());
    // if (index == 0) {
    //   getAllUsers();
    //   emit(ChangeBottomNavState());
    // }
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

  /// GET USER PROFILE
  UserModel? userProfile;
  void getUserProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Constances.uId)
        .get()
        .then((value) {
      userProfile = UserModel.fromJson(value.data()!);
      debugPrint(userProfile!.email);
      emit(GetAllUsersSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllUsersError(message: error.toString()));
    });
  }

  /// PROFILE IMAGE
  File? profileImage;
  Future<void> pickProfileImage() async {
    emit(PickProfileImageLoading());
    final pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccess());
      print('ss');
    } else {
      debugPrint('NotSelelcted');
      emit(PickProfileImageError());
    }
  }

  /// GET ALL USERS
  List<UserModel> allUsers = [];
  void getAllUsers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      if (allUsers.isEmpty) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userProfile!.uId) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        });
      }
      print(allUsers.length);
      emit(GetAllUsersSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllUsersError(message: error.toString()));
    });
  }
}
