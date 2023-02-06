// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i13;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../../domain/auth/datasource/auth_datasource.dart' as _i17;
import '../../domain/auth/repository/auth_repo.dart' as _i18;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i19;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i21;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i20;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i28;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i29;
import '../../flows/auth/domain/usecases/sign_up.dart' as _i30;
import '../../flows/auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart'
    as _i34;
import '../../flows/auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i35;
import '../../flows/main/data/datasource/events_datasource.dart' as _i22;
import '../../flows/main/data/repositories/events_repository_impl.dart' as _i24;
import '../../flows/main/domain/repositories/events_repository.dart' as _i23;
import '../../flows/main/domain/usecases/add_event.dart' as _i32;
import '../../flows/main/domain/usecases/get_categories.dart' as _i25;
import '../../flows/main/domain/usecases/get_users_events.dart' as _i26;
import '../../flows/main/presentation/pages/add_event/cubit/add_event_cubit.dart'
    as _i36;
import '../../flows/main/presentation/pages/main/cubit/main_page_cubit.dart'
    as _i27;
import '../../flows/menu/presentation/pages/calendar_page/cubit/calendar_cubit.dart'
    as _i4;
import '../../flows/menu/presentation/pages/find_event/cubit/find_event_cubit.dart'
    as _i6;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i15;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i33;
import '../../themes/theme_data_values.dart' as _i16;
import '../app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart'
    as _i3;
import '../firestore/firestore_events.dart' as _i9;
import '../firestore/firestore_users.dart' as _i10;
import '../navigation_service.dart' as _i12;
import '../token_service/token_service.dart' as _i31;
import 'injectible_init.dart' as _i37; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.CalendarCubit>(() => _i4.CalendarCubit());
  gh.lazySingleton<_i5.Connectivity>(() => registerModule.connectivity);
  gh.factory<_i6.FindEventCubit>(() => _i6.FindEventCubit());
  gh.lazySingleton<_i7.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i8.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i9.FirestoreEvents>(
      () => _i9.FirestoreEvents(get<_i8.FirebaseFirestore>()));
  gh.factory<_i10.FirestoreUsers>(
      () => _i10.FirestoreUsers(get<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i11.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.singleton<_i12.NavigationService>(_i12.NavigationService());
  await gh.factoryAsync<_i13.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  await gh.factoryAsync<_i14.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i15.SplashCubit>(() => _i15.SplashCubit());
  gh.lazySingleton<_i16.ThemeDataValues>(() => _i16.ThemeDataValues());
  gh.factory<_i17.AuthDataSourceI>(() => _i17.AuthDataSourceImpl(
        firebaseAuth: get<_i7.FirebaseAuth>(),
        firestoreUsers: get<_i10.FirestoreUsers>(),
      ));
  gh.factory<_i18.AuthRepositoryI>(
      () => _i19.AuthRepositoryImplementation(get<_i17.AuthDataSourceI>()));
  gh.factory<_i20.AuthRepositoryI>(
      () => _i21.AuthRepositoryImpl(get<_i17.AuthDataSourceI>()));
  gh.factory<_i22.EventsDataSourceI>(() =>
      _i22.EventsDataSourceImpl(firestoreEvents: get<_i9.FirestoreEvents>()));
  gh.factory<_i23.EventsRepositoryI>(
      () => _i24.EventsRepositoryImpl(get<_i22.EventsDataSourceI>()));
  gh.factory<_i25.GetCategoriesUseCase>(
      () => _i25.GetCategoriesUseCase(get<_i23.EventsRepositoryI>()));
  gh.factory<_i26.GetUsersEventsUseCase>(
      () => _i26.GetUsersEventsUseCase(get<_i23.EventsRepositoryI>()));
  gh.factory<_i27.MainPageCubit>(() => _i27.MainPageCubit(
        getUsersEvents: get<_i26.GetUsersEventsUseCase>(),
        getCategories: get<_i25.GetCategoriesUseCase>(),
      ));
  gh.factory<_i28.SignInUseCase>(
      () => _i28.SignInUseCase(get<_i20.AuthRepositoryI>()));
  gh.factory<_i29.SignOutUseCase>(
      () => _i29.SignOutUseCase(get<_i20.AuthRepositoryI>()));
  gh.factory<_i30.SignUpUseCase>(
      () => _i30.SignUpUseCase(get<_i20.AuthRepositoryI>()));
  gh.singleton<_i31.TokenManager>(_i31.TokenManager(
    secureStorage: get<_i11.FlutterSecureStorage>(),
    authRepository: get<_i18.AuthRepositoryI>(),
  ));
  gh.factory<_i32.AddEventUseCase>(
      () => _i32.AddEventUseCase(get<_i23.EventsRepositoryI>()));
  gh.factory<_i33.AppStateCubit>(() => _i33.AppStateCubit(
        authRepository: get<_i18.AuthRepositoryI>(),
        firebaseAuth: get<_i7.FirebaseAuth>(),
      ));
  gh.factory<_i34.SignInCubit>(
      () => _i34.SignInCubit(get<_i28.SignInUseCase>()));
  gh.factory<_i35.SignUpCubit>(
      () => _i35.SignUpCubit(get<_i30.SignUpUseCase>()));
  gh.factory<_i36.AddEventCubit>(() => _i36.AddEventCubit(
        addEventUseCase: get<_i32.AddEventUseCase>(),
        getCategoriesUseCase: get<_i25.GetCategoriesUseCase>(),
      ));
  return get;
}

class _$RegisterModule extends _i37.RegisterModule {}
