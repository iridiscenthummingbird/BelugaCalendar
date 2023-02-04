// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i11;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../../domain/auth/datasource/auth_datasource.dart' as _i15;
import '../../domain/auth/repository/auth_repo.dart' as _i16;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i17;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i19;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i18;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i25;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i26;
import '../../flows/auth/domain/usecases/sign_up.dart' as _i27;
import '../../flows/auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart'
    as _i30;
import '../../flows/auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i31;
import '../../flows/main/data/datasource/events_datasource.dart' as _i20;
import '../../flows/main/data/repositories/events_repository_impl.dart' as _i22;
import '../../flows/main/domain/repositories/events_repository.dart' as _i21;
import '../../flows/main/domain/usecases/get_users_events.dart' as _i23;
import '../../flows/main/presentation/pages/main/cubit/main_page_cubit.dart'
    as _i24;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i13;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i29;
import '../../themes/theme_data_values.dart' as _i14;
import '../app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart'
    as _i3;
import '../firestore/firestore_events.dart' as _i7;
import '../firestore/firestore_users.dart' as _i8;
import '../navigation_service.dart' as _i10;
import '../token_service/token_service.dart' as _i28;
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
  gh.lazySingleton<_i4.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i5.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i7.FirestoreEvents>(
      () => _i7.FirestoreEvents(get<_i6.FirebaseFirestore>()));
  gh.factory<_i8.FirestoreUsers>(
      () => _i8.FirestoreUsers(get<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i9.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.singleton<_i10.NavigationService>(_i10.NavigationService());
  await gh.factoryAsync<_i11.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i13.SplashCubit>(() => _i13.SplashCubit());
  gh.lazySingleton<_i14.ThemeDataValues>(() => _i14.ThemeDataValues());
  gh.factory<_i15.AuthDataSourceI>(() => _i15.AuthDataSourceImpl(
        firebaseAuth: get<_i5.FirebaseAuth>(),
        firestoreUsers: get<_i8.FirestoreUsers>(),
      ));
  gh.factory<_i16.AuthRepositoryI>(
      () => _i17.AuthRepositoryImplementation(get<_i15.AuthDataSourceI>()));
  gh.factory<_i18.AuthRepositoryI>(
      () => _i19.AuthRepositoryImpl(get<_i15.AuthDataSourceI>()));
  gh.factory<_i20.EventsDataSourceI>(() =>
      _i20.EventsDataSourceImpl(firestoreEvents: get<_i7.FirestoreEvents>()));
  gh.factory<_i21.EventsRepositoryI>(
      () => _i22.EventsRepositoryImpl(get<_i20.EventsDataSourceI>()));
  gh.factory<_i23.GetUsersEventsUseCase>(
      () => _i23.GetUsersEventsUseCase(get<_i21.EventsRepositoryI>()));
  gh.factory<_i24.MainPageCubit>(() =>
      _i24.MainPageCubit(getUsersEvents: get<_i23.GetUsersEventsUseCase>()));
  gh.factory<_i25.SignInUseCase>(
      () => _i25.SignInUseCase(get<_i18.AuthRepositoryI>()));
  gh.factory<_i26.SignOutUseCase>(
      () => _i26.SignOutUseCase(get<_i18.AuthRepositoryI>()));
  gh.factory<_i27.SignUpUseCase>(
      () => _i27.SignUpUseCase(get<_i18.AuthRepositoryI>()));
  gh.singleton<_i28.TokenManager>(_i28.TokenManager(
    secureStorage: get<_i9.FlutterSecureStorage>(),
    authRepository: get<_i16.AuthRepositoryI>(),
  ));
  gh.factory<_i29.AppStateCubit>(() => _i29.AppStateCubit(
        authRepository: get<_i16.AuthRepositoryI>(),
        firebaseAuth: get<_i5.FirebaseAuth>(),
      ));
  gh.factory<_i30.SignInCubit>(
      () => _i30.SignInCubit(get<_i25.SignInUseCase>()));
  gh.factory<_i31.SignUpCubit>(
      () => _i31.SignUpCubit(get<_i27.SignUpUseCase>()));
  return get;
}

class _$RegisterModule extends _i32.RegisterModule {}
