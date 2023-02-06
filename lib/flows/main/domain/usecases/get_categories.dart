import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase implements UseCase<List<Category>, NoParams> {
  final EventsRepositoryI repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams noParams) async {
    return await repository.getCategories();
  }
}