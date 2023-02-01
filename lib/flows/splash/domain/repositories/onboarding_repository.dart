abstract class OnboardingRepositoryI {
  Future<bool> checkIsFirstLaunch();
  Future<void> turnOffOnboarding();
}
