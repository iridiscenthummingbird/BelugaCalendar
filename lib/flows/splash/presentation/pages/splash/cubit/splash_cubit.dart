import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/check_is_first_launch.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashPageState> {
  SplashCubit({
    required this.checkIsFirstLaunch,
  }) : super(SplashLoading());

  final CheckIsFirstLaunch checkIsFirstLaunch;

  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 2));
    if (await checkIsFirstLaunch()) {
      emit(ShowOnboarding());
    } else {
      emit(ShowAuth());
    }
  }
}
