import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:routemaster/routemaster.dart';

import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/core/entities/token.dart';
import '../../services/token_service/token_service.dart';
import '../app_map.dart';
import '../auth_map.dart';
import '../splash_map.dart';

part '../app_state_cubit/app_state.dart';

@injectable
class AppStateCubit extends Cubit<AppState> {
  final TokenManager tokenManager;
  final AuthRepositoryI authRepository;
  //final FirebaseAuth firebaseAuth;

  AppStateCubit({
    required this.authRepository,
    required this.tokenManager,
    //required this.firebaseAuth,
  }) : super(SplashState());

  Future<void> signOut() async {
    await tokenManager.removeTokenData();
  }

  void startCheck() async {
    tokenManager.tokenStream.listen(
      (token) => _checkAuthStatus(token.tokenType),
    );
  }

  void checkAuthStatus() async {
    final token = await tokenManager.getToken();
    await _checkAuthStatus(token.tokenType);
  }

  _checkAuthStatus(TokenType tokenType) async {
    emit(UnauthorizedState());

    // switch (tokenType) {
    //   case TokenType.user:
    //     final currentUser = firebaseAuth.currentUser;
    //     if (currentUser != null) {
    //       final result = await authRepository
    //           .isUserSignedIn(currentUser.phoneNumber as String);
    //       result.fold(
    //         (failure) {
    //           emit(UnauthorizedState());
    //         },
    //         (user) {
    //           emit(AuthorizedState(user: user));
    //         },
    //       );
    //     } else {
    //       emit(UnauthorizedState());
    //     }
    //     break;
    //   case TokenType.none:
    //     emit(UnauthorizedState());
    // }
  }
}
