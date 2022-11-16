// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:xchat/core/utils/app_colors.dart';
// import 'package:xchat/core/utils/app_textstyle.dart';
// import 'package:xchat/core/utils/responsive.dart';
// import 'package:xchat/models/new_message_model.dart';
// import 'package:xchat/models/user_model.dart';
// import 'package:xchat/presentation/components/button.dart';
// import 'package:xchat/presentation/screens/home/cubit/app_cubit.dart';
// import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

// class MessageDetailsScreen extends StatefulWidget {


//   @override
//   State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
// }

// class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ;
        
      
 
//   }
// }

// Widget _buildMessage(context,{
//    required NewMessageModel  message
// }) {
//   return Align(
//     alignment: Alignment.topLeft,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: rwidth(context) / 50, vertical: rhight(context) / 80),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//               color: Colors.grey.withOpacity(.3)),
//           child: Text(
//             message.text,
//             style: AppTextStyle.messageBody
//                 .copyWith(color: AppColors.textColor, fontSize: 18),
//           ),
//         ),
//         Text(
//                        DateFormat('hh:mm a').format(DateTime.parse(message.dateTime)), 

//           style: AppTextStyle.messageBody
//               .copyWith(color: AppColors.textColor, fontSize: 11),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildMyMessage(context, {
//   required NewMessageModel  message
// }) {
//   return Align(
//     alignment: Alignment.topRight,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: rwidth(context) / 50, vertical: rhight(context) / 80),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomLeft: Radius.circular(20),
//               ),
//               color: AppColors.backgroundColor.withOpacity(.6)),
//           child: Text(
//             message.text,
//             style: AppTextStyle.messageBody
//                 .copyWith(color: AppColors.textColor, fontSize: 18),
//           ),
//         ),
//         Text(
//              DateFormat('hh:mm a').format(DateTime.parse(message.dateTime)), 
//           style: AppTextStyle.messageBody
//               .copyWith(color: AppColors.textColor, fontSize: 11),
//         ),
//       ],
//     ),
//   );
// }
