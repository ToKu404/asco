import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/services/preference_service.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/auth_models/user_credential_model.dart';
import 'package:asco/src/data/models/auth_models/user_model.dart';

abstract class AuthDataSource {
  Future<bool> createUser({required UserModel userModel});

  Future<bool> deleteUser({required String username});

  Future<UserCredentialModel> logIn({
    required String username,
    required String password,
  });

  Future<bool> logOut();

  Future<UserCredentialModel?> getUserCredential();
}

class AuthDataSourceImpl implements AuthDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;
  final AuthPreferenceHelper pref;

  AuthDataSourceImpl({required this.firestore, required this.pref}) {
    collectionReference = firestore.collection('users');
  }

  /// Create new user in Firestore database.
  @override
  Future<bool> createUser({required UserModel userModel}) async {
    try {
      final snapshot = await collectionReference
          .where('username', isEqualTo: userModel.username)
          .get();

      if (snapshot.docs.isEmpty) {
        return collectionReference
            .add(userModel.toDocument())
            .then((value) => true)
            .catchError((error) => false);
      }

      return false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  /// Delete user in Firestore database.
  @override
  Future<bool> deleteUser({required String username}) async {
    try {
      final snapshot = await collectionReference
          .where('username', isEqualTo: username)
          .get();

      final uid = snapshot.docs.first.id;

      return await collectionReference
          .doc(uid)
          .delete()
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  /// User login handler.
  @override
  Future<UserCredentialModel> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final snapshot = await collectionReference
          .where('username', isEqualTo: username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final passwordFromDb = snapshot.docs.first.get('password') as String;

        if (password == passwordFromDb) {
          final credential = UserCredentialModel(
            username: username,
            roleId: snapshot.docs[0].get('roleId'),
          );

          pref.setUserData(credential);

          return credential;
        } else {
          throw FirestoreException('password not match.');
        }
      } else {
        throw FirestoreException('user not found.');
      }
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  /// User logout handler.
  @override
  Future<bool> logOut() {
    try {
      return pref.removeUserData();
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  /// Get user credential
  @override
  Future<UserCredentialModel?> getUserCredential() async {
    try {
      final credential = await pref.getUser();

      if (credential != null) {
        final snapshot = await collectionReference
            .where('username', isEqualTo: credential.username)
            .get();

        if (snapshot.docs.isNotEmpty) return credential;

        throw FirestoreException('user not found');
      }

      return null;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }
}
