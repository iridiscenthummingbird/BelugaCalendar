import 'package:dio/dio.dart';
import 'package:beluga_calendar/flows/main/domain/entities/address.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/reverse_geocode_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/exceptions/api_exception.dart';
import '../../../../domain/shared_models/api/api_error.dart';

abstract class LocationDataSourceI {
  Future<List<String>> autocomplete(String input, double lat, double lon);
  Future<Address> reverseGeocode(Coords coords);
}

@Injectable(as: LocationDataSourceI)
class LocationDataSource implements LocationDataSourceI {
  final String _path = 'https://maps.googleapis.com/maps/api/';

  @override
  Future<Address> reverseGeocode(Coords coords) async {
    final response = await Dio().get(
      '${_path}geocode/json',
      queryParameters: {
        'latlng': '${coords.lat}, ${coords.lon}',
        'result_type': 'street_address',
      },
    );

    if (response.statusCode == 200) {
      if ((response.data['results'] as List).isNotEmpty) {
        final address = Address.fromJson(response.data['results'][0]);
        return address;
      }
    }
    throw ApiException([
      ApiError(title: ApiError.getErrorMessage(response)),
    ]);
  }

  @override
  Future<List<String>> autocomplete(
      String input, double lat, double lon) async {
    final response = await Dio().get(
      '${_path}place/autocomplete/json',
      queryParameters: {
        'strictbounds': true,
        'location': '$lat, $lon',
        'radius': 15000,
        'types': 'address',
        'input': input,
      },
    );
    if (response.statusCode == 200) {
      if ((response.data['predictions'] as List).isNotEmpty) {
        final List<String> predictions = (response.data['predictions'] as List)
            .map(
              (item) => item['structured_formatting']['main_text'] as String,
            )
            .toList();
        return predictions;
      }
    }
    throw ApiException([
      ApiError(title: ApiError.getErrorMessage(response)),
    ]);
  }
}
