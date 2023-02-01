import 'package:injectable/injectable.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class CheckIsFirstLaunch {
  final OnboardingRepositoryI repository;

  CheckIsFirstLaunch(this.repository);

  Future<bool> call() async {
    return await repository.checkIsFirstLaunch();
  }
}
