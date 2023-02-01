import 'package:dartz/dartz.dart';
import 'package:beluga_calendar/flows/main/domain/entities/address.dart';

import '../../../../domain/core/errors/failures.dart';
import '../usecases/reverse_geocode_usecase.dart';

abstract class LocationRepositoryI {
  Future<Either<Failure, List<String>>> autocomplete(
      String input, double lat, double lon);
  Future<Either<Failure, Address>> reverseGeocode(Coords coords);
}
