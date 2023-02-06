// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i12;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import '../../domain/auth/datasource/auth_datasource.dart' as _i16;
import '../../domain/auth/repository/auth_repo.dart' as _i17;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i18;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i20;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i19;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i28;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i29;
import '../../flows/auth/domain/usecases/sign_up.dart' as _i30;
import '../../flows/auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart'
    as _i35;
import '../../flows/auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i36;
import '../../flows/main/data/datasource/events_datasource.dart' as _i21;
import '../../flows/main/data/repositories/events_repository_impl.dart' as _i23;
import '../../flows/main/domain/repositories/events_repository.dart' as _i22;
import '../../flows/main/domain/usecases/add_event.dart' as _i32;
import '../../flows/main/domain/usecases/get_categories.dart' as _i24;
import '../../flows/main/domain/usecases/get_events_for_month.dart' as _i25;
import '../../flows/main/domain/usecases/get_users_events.dart' as _i26;
import '../../flows/main/presentation/pages/add_event/cubit/add_event_cubit.dart'
    as _i37;
import '../../flows/main/presentation/pages/main/cubit/main_page_cubit.dart'
    as _i27;
import '../../flows/menu/presentation/pages/calendar_page/cubit/calendar_cubit.dart'
    as _i34;
import '../../flows/menu/presentation/pages/find_event/cubit/find_event_cubit.dart'
    as _i5;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i14;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i33;
import '../../themes/theme_data_values.dart' as _i15;
import '../app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart'
    as _i3;
import '../firestore/firestore_events.dart' as _i8;
import '../firestore/firestore_users.dart' as _i9;
import '../navigation_service.dart' as _i11;
import '../token_service/token_service.dart' as _i31;
import 'injectible_init.dart' as _i38; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i5.FindEventCubit>(() => _i5.FindEventCubit());
  gh.lazySingleton<_i6.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i7.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i8.FirestoreEvents>(
      () => _i8.FirestoreEvents(get<_i7.FirebaseFirestore>()));
  gh.factory<_i9.FirestoreUsers>(
      () => _i9.FirestoreUsers(get<_i7.FirebaseFirestore>()));
  gh.lazySingleton<_i10.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.singleton<_i11.NavigationService>(_i11.NavigationService());
  await gh.factoryAsync<_i12.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  await gh.factoryAsync<_i13.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i14.SplashCubit>(() => _i14.SplashCubit());
  gh.lazySingleton<_i15.ThemeDataValues>(() => _i15.ThemeDataValues());
  gh.factory<_i16.AuthDataSourceI>(() => _i16.AuthDataSourceImpl(
        firebaseAuth: get<_i6.FirebaseAuth>(),
        firestoreUsers: get<_i9.FirestoreUsers>(),
      ));
  gh.factory<_i17.AuthRepositoryI>(
      () => _i18.AuthRepositoryImplementation(get<_i16.AuthDataSourceI>()));
  gh.factory<_i19.AuthRepositoryI>(
      () => _i20.AuthRepositoryImpl(get<_i16.AuthDataSourceI>()));
  gh.factory<_i21.EventsDataSourceI>(() =>
      _i21.EventsDataSourceImpl(firestoreEvents: get<_i8.FirestoreEvents>()));
  gh.factory<_i22.EventsRepositoryI>(
      () => _i23.EventsRepositoryImpl(get<_i21.EventsDataSourceI>()));
  gh.factory<_i24.GetCategoriesUseCase>(
      () => _i24.GetCategoriesUseCase(get<_i22.EventsRepositoryI>()));
  gh.factory<_i25.GetUsersEventsForMonthUseCase>(
      () => _i25.GetUsersEventsForMonthUseCase(get<_i22.EventsRepositoryI>()));
  gh.factory<_i26.GetUsersEventsUseCase>(
      () => _i26.GetUsersEventsUseCase(get<_i22.EventsRepositoryI>()));
  gh.factory<_i27.MainPageCubit>(() => _i27.MainPageCubit(
        getUsersEvents: get<_i26.GetUsersEventsUseCase>(),
        getCategories: get<_i24.GetCategoriesUseCase>(),
      ));
  gh.factory<_i28.SignInUseCase>(
      () => _i28.SignInUseCase(get<_i19.AuthRepositoryI>()));
  gh.factory<_i29.SignOutUseCase>(
      () => _i29.SignOutUseCase(get<_i19.AuthRepositoryI>()));
  gh.factory<_i30.SignUpUseCase>(
      () => _i30.SignUpUseCase(get<_i19.AuthRepositoryI>()));
  gh.singleton<_i31.TokenManager>(_i31.TokenManager(
    secureStorage: get<_i10.FlutterSecureStorage>(),
    authRepository: get<_i17.AuthRepositoryI>(),
  ));
  gh.factory<_i32.AddEventUseCase>(
      () => _i32.AddEventUseCase(get<_i22.EventsRepositoryI>()));
  gh.factory<_i33.AppStateCubit>(() => _i33.AppStateCubit(
        authRepository: get<_i17.AuthRepositoryI>(),
        firebaseAuth: get<_i6.FirebaseAuth>(),
      ));
  gh.factory<_i34.CalendarCubit>(
      () => _i34.CalendarCubit(get<_i25.GetUsersEventsForMonthUseCase>()));
  gh.factory<_i35.SignInCubit>(
      () => _i35.SignInCubit(get<_i28.SignInUseCase>()));
  gh.factory<_i36.SignUpCubit>(
      () => _i36.SignUpCubit(get<_i30.SignUpUseCase>()));
  gh.factory<_i37.AddEventCubit>(() => _i37.AddEventCubit(
        addEventUseCase: get<_i32.AddEventUseCase>(),
        getCategoriesUseCase: get<_i24.GetCategoriesUseCase>(),
      ));
  return get;
}

class _$RegisterModule extends _i38.RegisterModule {}
