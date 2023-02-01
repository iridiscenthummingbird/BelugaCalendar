import 'package:dartz/dartz.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_parameters.dart';
import 'package:beluga_calendar/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserProfileUseCase
    implements UseCase<void, UpdateUserProfileParameters> {
  final AuthRepositoryI repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      UpdateUserProfileParameters parameters) async {
    return await repository.updateUserProfile(parameters);
  }
}
