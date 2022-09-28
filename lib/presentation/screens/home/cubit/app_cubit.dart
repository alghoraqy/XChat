import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xchat/presentation/screens/home/cubit/app_states.dart';

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
}
