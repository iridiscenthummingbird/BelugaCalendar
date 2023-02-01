import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase implements UseCase<UserCredential, PhoneAuthCredential> {
  final AuthRepositoryI repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(
      PhoneAuthCredential parameters) async {
    return await repository.signIn(parameters);
  }
}
