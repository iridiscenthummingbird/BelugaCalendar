import 'package:beluga_calendar/flows/main/presentation/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../../navigation/app_state_cubit/app_state_cubit.dart';
import '../../../../../services/injectible/injectible_init.dart';
import 'cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const path = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => getIt<SplashCubit>()..load(),
        child: BlocListener<SplashCubit, SplashPageState>(
          listener: (context, state) async {
            if (state is ShowOnboarding) {
              Routemaster.of(context).replace(MainPage.path);
            } else if (state is ShowAuth) {
              context.read<AppStateCubit>().startCheck();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text("SPLASH"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
