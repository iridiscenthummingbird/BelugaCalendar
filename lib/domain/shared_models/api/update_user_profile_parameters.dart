import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_data.dart';

class UpdateUserProfileParameters {
  UpdateUserProfileParameters({
    required this.userId,
    required this.data,
  });

  final String userId;
  final UpdateUserProfileData data;
}
