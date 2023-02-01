import 'package:firebase_auth/firebase_auth.dart';
import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/update_user_profile_data.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/services/firestore/firestore_users.dart';
import 'package:injectable/injectable.dart';

abstract class AuthDataSourceI {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    required Duration timeout,
  });
  Future<UserCredential> signIn(PhoneAuthCredential credential);
  Future<void> signOut();
  Future<UserModel> getUserByPhoneNumber(String phoneNumber);
  Future<void> updateUserProfile({
    required String userId,
    required UpdateUserProfileData data,
  });
}

@Injectable(as: AuthDataSourceI)
class AuthDataSourceImpl implements AuthDataSourceI {
  //AuthDataSourceImpl({
  //required this.firebaseAuth,
  //required this.firestoreUsers,
  //});

  //final FirebaseAuth firebaseAuth;
  //final FirestoreUsers firestoreUsers;

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    required Duration timeout,
  }) async {
    throw UnimplementedError();

    // try {
    //   await firebaseAuth.verifyPhoneNumber(
    //     phoneNumber: phoneNumber,
    //     verificationCompleted: verificationCompleted,
    //     verificationFailed: verificationFailed,
    //     codeSent: codeSent,
    //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    //     timeout: timeout,
    //   );
    // } on FirebaseAuthException catch (exception) {
    //   throw (ServerFailure(message: exception.code));
    // } catch (exception) {
    //   throw (OtherFailure(message: 'Failed to verify phone number $exception'));
    // }
  }

  @override
  Future<UserCredential> signIn(PhoneAuthCredential credential) async {
    throw UnimplementedError();

    // try {
    //   final userCredential =
    //       await firebaseAuth.signInWithCredential(credential);
    //   final phoneNumber = userCredential.user!.phoneNumber as String;
    //   final userExists = await firestoreUsers.checkUserExists(phoneNumber);
    //   if (!userExists) {
    //     await firestoreUsers.addUser(
    //       UpdateUserProfileData(
    //         phoneNumber: phoneNumber,
    //         email: '',
    //         isTermsAccepted: false,
    //       ),
    //     );
    //   }
    //   return userCredential;
    // } on FirebaseAuthException catch (exception) {
    //   throw (ServerFailure(message: exception.code));
    // } catch (exception) {
    //   throw (OtherFailure(message: 'Failed to verify phone number $exception'));
    // }
  }

  @override
  Future<UserModel> getUserByPhoneNumber(String phoneNumber) async {
    throw UnimplementedError();

    // try {
    //   final result = await firestoreUsers.getUserByPhoneNumber(phoneNumber);
    //   return result;
    // } catch (exception) {
    //   throw ServerFailure(message: 'Something went wrong: $exception');
    // }
  }

  @override
  Future<void> updateUserProfile(
      {required String userId, required UpdateUserProfileData data}) async {
    throw UnimplementedError();

    // try {
    //   await firestoreUsers.updateUser(userId, data);
    // } catch (exception) {
    //   throw ServerFailure(message: 'Could not update profile: $exception');
    // }
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError();

    // try {
    //   firebaseAuth.signOut();
    // } catch (exception) {
    //   throw (ServerFailure(message: exception.toString()));
    // }
  }
}
