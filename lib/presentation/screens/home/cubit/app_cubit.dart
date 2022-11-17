import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/constances.dart';
import 'package:xchat/models/message_model.dart';
import 'package:xchat/models/new_message_model.dart';
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
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.initialRoute, (route) => false);
      emit(ChangeState());
    });
  }

  TextEditingController searchController = TextEditingController();

  /// EDIT PROFILE CONTROLLERS
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController sendMessageController = TextEditingController();

  /// BOTTOM NAV
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



  /// GET USER PROFILE
  UserModel? userProfile;
  bool load=true;
  Future getUserProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constances.uId)
        .get()
        .then((value) {
      userProfile = UserModel.fromJson(value.data()!);
      debugPrint(userProfile!.email);
      emit(GetUserProfileSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserProfileError(message: error.toString()));
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

  Future getAllUsers() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      if (allUsers.isEmpty) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userProfile!.uId) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        });
      }

      // print(allUsers.length);
      emit(GetAllUsersSuccess());
    }).catchError((error) {
      debugPrint('getAllUsers Error: ${error.toString()}');
      emit(GetAllUsersError(message: 'getAllUsers Error: ${error.toString()}'));
    });
  }

  /// UPLOAD PROFILE IMAGE
  String? profileImageUrl;
  Future uploadProfileImage(context) async {
    emit(UploadProfileImageLoading());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        updateUserProfile(context);
        //  updateUserProfileImage(context);
        //  emit(UploadProfileImageSuccess());
      }).catchError((error) {
        print('getDownloadURL : $error');
      });
    }).catchError((error) {
      print('uploadProfileImage Error : $error');
      emit(UploadProfileImageError());
    });
  }

  /// UPDATE USER PROFILE
  Future updateUserProfile(context) async {
    emit(UpdateUserProfileLoading());
    UserModel model = UserModel(
      userName: userNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      image: profileImageUrl ?? userProfile!.image,
      uId: userProfile!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userProfile!.uId)
        .update(model.tomap())
        .then((value) {
      getUserProfile().then((value) {
        load = true;
        Navigator.pop(context);
      });
    }).catchError((error) {
      print('updateUser Profile : $error');
    });
  }

  /// UPDATE USER
  Future updateUser(context) async {
    if (profileImage != null) {
      print(profileImage!.path);
      await uploadProfileImage(context);
    } else {
      await updateUserProfile(context);
    }
  }

  /// SEND MESSAGES
  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    NewMessageModel model = NewMessageModel(
        receiverId: receiverId,
        senderId: userProfile!.uId,
        text: text,
        dateTime: dateTime);

    /// SEND FOR ME
    FocusManager.instance.primaryFocus?.unfocus();
    sendMessageController.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userProfile!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      // if (!uploadchatWithList.contains(receiverId)) {
      //   FirebaseFirestore.instance.collection('users').doc(userProfile!.uId).update({
      //     'isChat':true
      //   });
      //   uploadchatWithList.add(receiverId);
      //    addChatWithList().then((value) {
      //    chatWithUsers = [];
      //    getChatWithUsers().then((value) {
      //    emit(SendMessageSuccess());
      //    });
      // });
      // }
      emit(SendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError());
    });

    /// SEND FOR RECEIVER
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userProfile!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError());
    });
  }

  /// GET MESSAGES
  // List<NewMessageModel> myMessages=[];
  // Stream getMessage({
  //   required String receiverId,
  // })async* {
  //    myMessages=[];
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userProfile!.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //         myMessages=[];
  //         if (event.docs.isNotEmpty) {
  //           event.docs.forEach((element) {
  //           myMessages.add(NewMessageModel.fromJson(element.data()));
  //         emit(GetMyMessagesSuccess());
  //         });
  //         print(myMessages.first.text);
  //         emit(GetMyMessagesSuccess());
  //         }

  //         emit(GetMyMessagesSuccess());
  //       },);
  // }

  // List uploadchatWithList = [];
  // Future addChatWithList() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userProfile!.uId)
  //       .update({'chatWith': uploadchatWithList.toSet().toList()}).then(
  //           (value) {
  //     getChatWith();
  //     print(uploadchatWithList);
  //   }).catchError((error) {
  //     print(error.toString());
  //   });
  //   // print(id);
  // }

  // List getChatWithList = [];
  // Future getChatWith() async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userProfile!.uId)
  //       .get()
  //       .then((value) {
  //     if (value.data()!.containsKey('chatWith')) {
  //       getChatWithList = value.data()!['chatWith'];
  //       uploadchatWithList = getChatWithList;
  //     }
  //     //  print(getChatWithList);
  //   }).catchError((error) {
  //     print('getChatWith :$error');
  //   });
  // }

// List<UserModel> chatWithUsers = [];
//   Future getChatWithUsers() async {
//     //  print('getChatWithList : $getChatWithList');
//     if (getChatWithList.toSet().toList().isNotEmpty) {
//       getChatWithList.toSet().toList().forEach((element) {
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(element)
//             .get()
//             .then((value) {
//           chatWithUsers.add(UserModel.fromJson(value.data()!));
//           emit(GetMyMessagesSuccess());
//            print(chatWithUsers);
//         }).catchError((error) {
//           print('error is ${error.toString()}');
//           emit(GetMyMessagesError());
//         });
//       });
//     }
//   }

  // void searchUser({required String userName}) {
  //   FirebaseFirestore.instance
  //       .collection('users').startAt(values)
  //       .get()
  //       .then((value) {
  //     print(value.docs.first.data()['email']);
  //   }).catchError((error) {
  //     print('searchUser : $error');
  //   });
  // }

  List<UserModel> searchedUsers = [];
  Future searchUser(String text) async {
    if (text.isNotEmpty) {
      final suggestions = allUsers.where((user) {
        final usertName = user.userName.toLowerCase();
        final input = text.toLowerCase();
        return usertName.contains(input);
      }).toList();
      searchedUsers = suggestions;
      emit(ChangeSearchState());
      print(searchedUsers);
      print(text);
    } else {
      searchedUsers = [];
      emit(ChangeSearchState());
    }
  }
  /// CHECK INTERNET
  bool connectionState = true;
  Future<StreamSubscription<InternetConnectionStatus>> checkInternet() async {
    return InternetConnectionChecker().onStatusChange.listen((event) {
      final connection = event == InternetConnectionStatus.connected;
      connectionState = connection;
      emit(CheckInternetSuccess());
    });
  }

}
