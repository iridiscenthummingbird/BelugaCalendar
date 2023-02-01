import 'package:dartz/dartz.dart';
import 'package:beluga_calendar/flows/main/data/datasource/location_datasource.dart';
import 'package:beluga_calendar/flows/main/domain/entities/address.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/location_repository.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/reverse_geocode_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';

@Injectable(as: LocationRepositoryI)
class LocationRepository implements LocationRepositoryI {
  final LocationDataSourceI dataSource;

  LocationRepository(this.dataSource);

  @override
  Future<Either<Failure, Address>> reverseGeocode(Coords coords) async {
    try {
      final result = await dataSource.reverseGeocode(coords);
      return Right(result);
    } catch (exeption) {
      return Left(
        OtherFailure(message: exeption.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> autocomplete(
      String input, double lat, double lon) async {
    try {
      final result = await dataSource.autocomplete(input, lat, lon);
      return Right(result.toSet().toList());
    } catch (exeption) {
      return Left(
        OtherFailure(message: exeption.toString()),
      );
    }
  }
}
