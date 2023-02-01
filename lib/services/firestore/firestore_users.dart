// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_data.dart';
// import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class FirestoreUsers {
//   FirestoreUsers(this.firebaseFirestore)
//       : _usersCollection = firebaseFirestore.collection('users');

//   final FirebaseFirestore firebaseFirestore;

//   late final CollectionReference<Map<String, dynamic>> _usersCollection;

//   Future<bool> checkUserExists(String phoneNumber) async {
//     final result = await _usersCollection
//         .where('phoneNumber', isEqualTo: phoneNumber)
//         .get();
//     return result.docs.isNotEmpty;
//   }

//   Future<void> addUser(UpdateUserProfileData data) async =>
//       await _usersCollection.add(data.toJson());

//   Future<void> updateUser(String userId, UpdateUserProfileData data) async =>
//       await _usersCollection.doc(userId).update(
//             data.toJson(),
//           );

//   Future<UserModel> getUserByPhoneNumber(String phoneNumber) async {
//     final result = await _usersCollection
//         .where('phoneNumber', isEqualTo: phoneNumber)
//         .get();
//     final user = result.docs.first;
//     final userData = user.data();
//     return UserModel(
//       id: user.id,
//       phone: userData['phoneNumber'],
//       email: userData['email'],
//       isTermsAccepted: userData['isTermsNConditionsAccepted'],
//     );
//   }
// }
