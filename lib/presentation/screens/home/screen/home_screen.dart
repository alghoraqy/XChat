import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Scaffold(
            appBar: AppBar(
              title: Text('home'),
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).closeApp(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          );
        },
      ),
    );
  }
}
