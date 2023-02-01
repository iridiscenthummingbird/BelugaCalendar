// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i18;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import '../../domain/auth/datasource/auth_datasource.dart' as _i4;
import '../../domain/auth/repository/auth_repo.dart' as _i5;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i6;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i8;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i7;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i21;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i22;
import '../../flows/auth/domain/usecases/update_user_profile.dart' as _i26;
import '../../flows/auth/domain/usecases/verify_phone_number.dart' as _i27;
import '../../flows/main/data/datasource/location_datasource.dart' as _i11;
import '../../flows/main/data/repositories/location_repository.dart' as _i13;
import '../../flows/main/domain/repositories/location_repository.dart' as _i12;
import '../../flows/main/domain/usecases/autocomplete_usecase.dart' as _i29;
import '../../flows/main/domain/usecases/reverse_geocode_usecase.dart' as _i19;
import '../../flows/splash/data/datasources/onboarding_local_data_source.dart'
    as _i15;
import '../../flows/splash/data/repositories/onboarding_repository_impl.dart'
    as _i17;
import '../../flows/splash/domain/repositories/onboarding_repository.dart'
    as _i16;
import '../../flows/splash/domain/usecases/check_is_first_launch.dart' as _i30;
import '../../flows/splash/domain/usecases/turn_off_onboarding.dart' as _i25;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i31;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i28;
import '../../themes/theme_data_values.dart' as _i23;
import '../app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart'
    as _i3;
import '../navigation_service.dart' as _i14;
import '../token_service/token_service.dart' as _i24;
import 'injectible_init.dart' as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.AppInternalNotificationsBloc>(
      () => _i3.AppInternalNotificationsBloc());
  gh.factory<_i4.AuthDataSourceI>(() => _i4.AuthDataSourceImpl());
  gh.factory<_i5.AuthRepositoryI>(
      () => _i6.AuthRepositoryImplementation(get<_i4.AuthDataSourceI>()));
  gh.factory<_i7.AuthRepositoryI>(
      () => _i8.AuthRepositoryImpl(get<_i4.AuthDataSourceI>()));
  gh.lazySingleton<_i9.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i10.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.factory<_i11.LocationDataSourceI>(() => _i11.LocationDataSource());
  gh.factory<_i12.LocationRepositoryI>(
      () => _i13.LocationRepository(get<_i11.LocationDataSourceI>()));
  gh.singleton<_i14.NavigationService>(_i14.NavigationService());
  gh.factory<_i15.OnboardingLocalDataSourceI>(
      () => _i15.OnboardingLocalDataSourceImpl());
  gh.factory<_i16.OnboardingRepositoryI>(() =>
      _i17.OnboardingRepositoryImpl(get<_i15.OnboardingLocalDataSourceI>()));
  await gh.factoryAsync<_i18.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  gh.factory<_i19.ReverseGeocodeUsecase>(
      () => _i19.ReverseGeocodeUsecase(get<_i12.LocationRepositoryI>()));
  await gh.factoryAsync<_i20.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i21.SignInUseCase>(
      () => _i21.SignInUseCase(get<_i7.AuthRepositoryI>()));
  gh.factory<_i22.SignOutUseCase>(
      () => _i22.SignOutUseCase(get<_i7.AuthRepositoryI>()));
  gh.lazySingleton<_i23.ThemeDataValues>(() => _i23.ThemeDataValues());
  gh.singleton<_i24.TokenManager>(_i24.TokenManager(
    secureStorage: get<_i10.FlutterSecureStorage>(),
    authRepository: get<_i5.AuthRepositoryI>(),
  ));
  gh.factory<_i25.TurnOffOnboarding>(
      () => _i25.TurnOffOnboarding(get<_i16.OnboardingRepositoryI>()));
  gh.factory<_i26.UpdateUserProfileUseCase>(
      () => _i26.UpdateUserProfileUseCase(get<_i7.AuthRepositoryI>()));
  gh.factory<_i27.VerifyPhoneNumberUseCase>(
      () => _i27.VerifyPhoneNumberUseCase(get<_i7.AuthRepositoryI>()));
  gh.factory<_i28.AppStateCubit>(() => _i28.AppStateCubit(
        authRepository: get<_i5.AuthRepositoryI>(),
        tokenManager: get<_i24.TokenManager>(),
      ));
  gh.factory<_i29.AutocompleteUsecase>(
      () => _i29.AutocompleteUsecase(get<_i12.LocationRepositoryI>()));
  gh.factory<_i30.CheckIsFirstLaunch>(
      () => _i30.CheckIsFirstLaunch(get<_i16.OnboardingRepositoryI>()));
  gh.factory<_i31.SplashCubit>(() =>
      _i31.SplashCubit(checkIsFirstLaunch: get<_i30.CheckIsFirstLaunch>()));
  return get;
}

class _$RegisterModule extends _i32.RegisterModule {}
