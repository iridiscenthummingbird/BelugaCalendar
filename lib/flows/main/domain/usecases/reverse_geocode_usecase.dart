import 'package:dartz/dartz.dart';
import 'package:beluga_calendar/flows/main/domain/entities/address.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';
import '../../../../domain/core/usecase/usecase.dart';
import '../repositories/location_repository.dart';

@injectable
class ReverseGeocodeUsecase implements UseCase<void, Coords> {
  final LocationRepositoryI repository;

  ReverseGeocodeUsecase(this.repository);

  @override
  Future<Either<Failure, Address>> call(Coords coords) async {
    return await repository.reverseGeocode(coords);
  }
}

class Coords {
  final double lat;
  final double lon;

  Coords({
    required this.lat,
    required this.lon,
  });
}
