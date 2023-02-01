import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_parameters.dart';
import 'package:beluga_calendar/domain/shared_models/api/verify_phone_number_parameters.dart';

abstract class AuthRepositoryI {
  Future<Either<Failure, void>> verifyPhoneNumber(
      VerifyPhoneNumberParameters parameters);
  Future<Either<Failure, UserCredential>> signIn(
      PhoneAuthCredential credential);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> updateUserProfile(
      UpdateUserProfileParameters parameters);
}
