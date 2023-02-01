import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/core/entities/token.dart';
import '../../domain/core/models/token_model.dart';

@singleton
class TokenManager {
  FlutterSecureStorage secureStorage;
  AuthRepositoryI authRepository;
  final StreamController _tokenStreamController;

  Stream get tokenStream => _tokenStreamController.stream;

  TokenManager({
    required this.secureStorage,
    required this.authRepository,
  }) : _tokenStreamController = StreamController(sync: true) {
    getToken().then((value) => _tokenStreamController.add(value));
  }

  static const String _tokenKey = 'token';

  Future<Token> getToken() async {
    String? token;
    try {
      token = await secureStorage.read(key: _tokenKey);
    } catch (e) {
      await secureStorage.deleteAll();
    }

    Token newToken = Token.ofNoneType();
    if (token != null) {
      try {
        newToken = TokenModel.fromSecureStorage(json: json.decode(token));
        return newToken;
      } catch (e) {
        debugPrint(e.toString());
        await secureStorage.delete(key: _tokenKey);
        return newToken;
      }
    } else {
      return newToken;
    }
  }

  Future<void> setToken(
    TokenModel token, {
    bool isRefreshed = false,
  }) async {
    await secureStorage.write(
      key: _tokenKey,
      value: json.encode(token.toSecureJson()),
    );
    final newToken = await getToken();
    if (!isRefreshed) {
      _tokenStreamController.add(newToken);
    } else {
      return;
    }
  }

  Future<void> removeTokenData() async {
    await secureStorage.delete(key: _tokenKey);
    _tokenStreamController.add(Token.ofNoneType());
  }

  Future<TokenType> currentTokenType() async {
    try {
      final token = await getToken();
      return token.tokenType;
    } catch (e) {
      return TokenType.none;
    }
  }

  Future<void> requestOAuthToken(
    String code,
  ) async {
    try {
      final tokenOrFailure = await authRepository.getOAuthToken();
      tokenOrFailure.fold(
        (l) => debugPrint('failed to get token'),
        (r) {
          final TokenModel token = TokenModel(
            tokenType: TokenType.user,
            refreshToken: r.refreshToken,
            token: r.token,
          );
          setToken(token);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      final token = await getToken();
      if (token.refreshToken != null) {
        final tokenOrFailure = await authRepository.getRefreshToken(token.refreshToken!);
        tokenOrFailure.fold(
          (l) => debugPrint('failed to get token'),
          (r) {
            final TokenModel token = TokenModel(
              tokenType: TokenType.none,
              refreshToken: r.refreshToken,
              token: r.token,
            );
            setToken(token);
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
