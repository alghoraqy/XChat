import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/core/utils/app_colors.dart';
import 'package:xchat/core/utils/app_textstyle.dart';
import 'package:xchat/core/utils/assets_manager.dart';
import 'package:xchat/core/utils/responsive.dart';
import 'package:xchat/presentation/components/button.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_cubit.dart';
import 'package:xchat/presentation/screens/Sign%20Up/cubit/signup_states.dart';

class ChoosePictureScreen extends StatelessWidget {
  const ChoosePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SignUpCubit cubit = SignUpCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: AppColors.baseColor),
            backgroundColor: AppColors.baseColor,
            elevation: 0,
          ),
          body: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: rhight(context) / 2.8,
                            width: rwidth(context),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              color: AppColors.baseColor,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Choose Picture',
                              style: AppTextStyle.textAppNamestyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: rhight(context) / 10,
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: rhight(context) / 4,
                          width: rwidth(context) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: cubit.profileImage == null
                              ? const FadeInImage(
                                  placeholder: AssetImage(ImgAsset.loading),
                                  image: NetworkImage(ImgAsset.defaultImg),
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover)
                              : FadeInImage(
                                  placeholder: AssetImage(ImgAsset.loading),
                                  image: FileImage(cubit.profileImage!),
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover),
                        ),
                        Positioned(
                          left: rwidth(context) / 3,
                          child: MaterialButton(
                            onPressed: () {
                              cubit.pickProfileImage();
                            },
                            height: rhight(context) / 12,
                            color: AppColors.textColor.withOpacity(.8),
                            elevation: 0,
                            shape: const CircleBorder(
                              side: BorderSide(color: Colors.white, width: 5),
                            ),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(bottom: rhight(context) / 30),
                child: MyButton(
                  onPressed: () {},
                  hight: rhight(context) / 14,
                  width: rwidth(context) / 1.2,
                  child: const Text(
                    'Confirm',
                    style: AppTextStyle.buttonStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
