import 'package:injectable/injectable.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

@Injectable(as: OnboardingRepositoryI)
class OnboardingRepositoryImpl implements OnboardingRepositoryI {
  final OnboardingLocalDataSourceI localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<bool> checkIsFirstLaunch() async {
    return await localDataSource.checkIsFirstLaunch();
  }

  @override
  Future<void> turnOffOnboarding() async {
    await localDataSource.turnOffOnboarding();
  }
}
