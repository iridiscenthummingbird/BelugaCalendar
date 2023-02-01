import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/injectible/injectible_init.dart';

abstract class OnboardingLocalDataSourceI {
  Future<bool> checkIsFirstLaunch();
  Future<void> turnOffOnboarding();
}

@Injectable(as: OnboardingLocalDataSourceI)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSourceI {
  final String _launchFieldName = 'isFirstLaunch';

  @override
  Future<bool> checkIsFirstLaunch() async {
    final SharedPreferences sharedPreferences = getIt<SharedPreferences>();
    return sharedPreferences.getBool(_launchFieldName) ?? true;
  }

  @override
  Future<void> turnOffOnboarding() async {
    final SharedPreferences sharedPreferences = getIt<SharedPreferences>();
    sharedPreferences.setBool(_launchFieldName, false);
  }
}
