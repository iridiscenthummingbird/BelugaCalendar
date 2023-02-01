import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';
import '../../../../domain/core/usecase/usecase.dart';
import '../repositories/location_repository.dart';

@injectable
class AutocompleteUsecase implements UseCase<void, AutocompleteParams> {
  final LocationRepositoryI repository;

  AutocompleteUsecase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(AutocompleteParams params) async {
    return await repository.autocomplete(params.input, params.lat, params.lon);
  }
}

class AutocompleteParams {
  final String input;
  final double lat;
  final double lon;

  AutocompleteParams({
    required this.input,
    required this.lat,
    required this.lon,
  });
}
