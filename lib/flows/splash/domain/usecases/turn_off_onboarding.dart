import 'package:beluga_calendar/flows/splash/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TurnOffOnboarding {
  final OnboardingRepositoryI repository;

  TurnOffOnboarding(this.repository);

  Future<void> call() async {
    await repository.turnOffOnboarding();
  }
}
