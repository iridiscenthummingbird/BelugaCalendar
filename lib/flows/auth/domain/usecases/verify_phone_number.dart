import 'package:dartz/dartz.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/verify_phone_number_parameters.dart';
import 'package:beluga_calendar/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyPhoneNumberUseCase
    implements UseCase<void, VerifyPhoneNumberParameters> {
  final AuthRepositoryI repository;

  VerifyPhoneNumberUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      VerifyPhoneNumberParameters parameters) async {
    return await repository.verifyPhoneNumber(parameters);
  }
}
