import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/models/new_message_model.dart';
import 'package:xchat/models/user_model.dart';
import 'package:xchat/presentation/screens/home/cubit/app_cubit.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

// ignore: must_be_immutable
class DetailsOfMessage extends StatefulWidget {
  UserModel userModel;
  DetailsOfMessage({super.key, required this.userModel});

  @override
  State<DetailsOfMessage> createState() => _DetailsOfMessageState();
}

class _DetailsOfMessageState extends State<DetailsOfMessage> {
  ScrollController messageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AppCubit.get(context).userProfile!.uId)
            .collection('chats')
            .doc(widget.userModel.uId)
            .collection('messages')
            .orderBy('dateTime')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (messageController.hasClients) {
                    messageController
                        .jumpTo(messageController.position.maxScrollExtent);
                  }
                });
                return Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  appBar: AppBar(
                    backgroundColor: AppColors.backgroundColor,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 28,
                        color: AppColors.textColor,
                      ),
                    ),
                    title: Row(
                      children: [
                        Container(
                          height: rhight(context) / 15,
                          width: rwidth(context) / 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image(
                            image: CachedNetworkImageProvider(widget.userModel.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: rwidth(context) / 50,
                        ),
                        Expanded(
                          child: Text(
                            widget.userModel.userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.messageTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(top: rhight(context) / 70),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.only(top: rhight(context) / 50),
                        child: Column(
                          children: [
                            snapshot.data!.docs.length == 0
                                ? Expanded(
                                    child: Center(
                                      child: Lottie.asset('assets/lottie/chat.json',height: rhight(context)/2.05, fit: BoxFit.cover),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        controller: messageController,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: rwidth(context) / 40,
                                            vertical: rhight(context) / 50),
                                        itemBuilder: (context, index) {
                                          var message =
                                              snapshot.data!.docs[index];
                                          if (cubit.userProfile!.uId ==
                                              message.data()['senderId']) {
                                            return _buildMyMessage(context,
                                                message:
                                                    NewMessageModel.fromJson(
                                                        message.data()));
                                          }
                                          return _buildMessage(context,
                                              message: NewMessageModel.fromJson(
                                                  message.data()));
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: rhight(context) / 80,
                                          );
                                        },
                                        itemCount: snapshot.data!.docs.length),
                                  ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: rwidth(context) / 30,
                                  vertical: rhight(context) / 70),
                              child: TextFormField(
                                controller: cubit.sendMessageController,
                                minLines: 1,
                                maxLines: 5,
                                autofocus: false,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Type Your Message Here ...',
                                  hintStyle: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: rwidth(context) / 40),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  filled: true,
                                  fillColor:
                                      AppColors.backgroundColor.withOpacity(.8),
                                  suffixIcon: MaterialButton(
                                    onPressed: () {
                                      if (cubit.sendMessageController.text
                                          .isNotEmpty) {
                                        cubit.sendMessage(
                                            receiverId: widget.userModel.uId,
                                            text: cubit
                                                .sendMessageController.text,
                                            dateTime:
                                                DateTime.now().toString());
                                      }
                                    },
                                    height: rhight(context) / 11.5,
                                    color: AppColors.baseColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    )),
                                    child: const Icon(
                                      Icons.send_rounded,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 28,
                  color: AppColors.textColor,
                ),
              ),
              title: Row(
                children: [
                  Container(
                    height: rhight(context) / 15,
                    width: rwidth(context) / 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: NetworkImage(widget.userModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: rwidth(context) / 50,
                  ),
                  Expanded(
                    child: Text(
                      widget.userModel.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.messageTitle,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: rhight(context) / 70),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(top: rhight(context) / 50),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget _buildMessage(context, {required NewMessageModel message}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: rwidth(context) / 50, vertical: rhight(context) / 80),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.grey.withOpacity(.3)),
          child: Text(
            message.text,
            style: AppTextStyle.messageBody
                .copyWith(color: AppColors.textColor, fontSize: 18),
          ),
        ),
        Text(
          DateFormat('hh:mm a').format(DateTime.parse(message.dateTime)),
          style: AppTextStyle.messageBody
              .copyWith(color: AppColors.textColor, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget _buildMyMessage(context, {required NewMessageModel message}) {
  return Align(
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: rwidth(context) / 50, vertical: rhight(context) / 80),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: AppColors.backgroundColor.withOpacity(.6)),
          child: Text(
            message.text,
            style: AppTextStyle.messageBody
                .copyWith(color: AppColors.textColor, fontSize: 18),
          ),
        ),
        Text(
          DateFormat('hh:mm a').format(DateTime.parse(message.dateTime)),
          style: AppTextStyle.messageBody
              .copyWith(color: AppColors.textColor, fontSize: 11),
        ),
      ],
    ),
  );
}
