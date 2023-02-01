import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beluga_calendar/domain/auth/datasource/auth_datasource.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_parameters.dart';
import 'package:beluga_calendar/domain/shared_models/api/verify_phone_number_parameters.dart';
import 'package:beluga_calendar/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepositoryI)
class AuthRepositoryImpl implements AuthRepositoryI {
  final AuthDataSourceI remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(
      VerifyPhoneNumberParameters parameters) async {
    try {
      final result = await remoteDataSource.verifyPhoneNumber(
        phoneNumber: parameters.phoneNumber,
        verificationCompleted: parameters.verificationCompleted,
        verificationFailed: parameters.verificationFailed,
        codeSent: parameters.codeSent,
        codeAutoRetrievalTimeout: parameters.codeAutoRetrievalTimeout,
        timeout: parameters.timeout,
      );
      return Right(result);
    } on Failure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(
      PhoneAuthCredential credential) async {
    try {
      final result = await remoteDataSource.signIn(credential);
      return Right(result);
    } on Failure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await remoteDataSource.signOut();
      return Right(result);
    } on Failure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(
      UpdateUserProfileParameters parameters) async {
    try {
      final result = await remoteDataSource.updateUserProfile(
        userId: parameters.userId,
        data: parameters.data,
      );
      return Right(result);
    } on Failure catch (exception) {
      return Left(exception);
    }
  }
}
