import 'package:asco/src/data/models/auth_models/user_credential.dart';
import 'package:asco/src/data/models/auth_models/user_model.dart';
import 'package:asco/src/data/services/preferences_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthDataSources {
  Future<bool> createUser({required UserModel userModel});
  Future<bool> deleteUser({required String username});
  Future<UserCredentialModel> logIn(
      {required String username, required String password});
  Future<UserCredentialModel?> getUserCredential();
  Future<bool> logOut();
}

class AuthDataSourcesImpl implements AuthDataSources {
  final FirebaseFirestore firestore;
  final AuthPreferenceHelper authPreferenceHelper;

  AuthDataSourcesImpl(
      {required this.firestore, required this.authPreferenceHelper}) {
    userCollectionRef = firestore.collection('users');
  }

  late CollectionReference userCollectionRef;

  //! Membuat User baru di firebase
  @override
  Future<bool> createUser({required UserModel userModel}) async {
    try {
      QuerySnapshot snapshot = await userCollectionRef
          .where("username", isEqualTo: userModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return false;
      } else {
        return userCollectionRef
            .add(
              userModel.toDocument(),
            )
            .then((value) => true)
            .catchError((error) => false);
      }
    } catch (e) {
      throw Exception();
    }
  }

  //! Login
  @override
  Future<UserCredentialModel> logIn(
      {required String username, required String password}) async {
    try {
      QuerySnapshot snapshot =
          await userCollectionRef.where("username", isEqualTo: username).get();

      if (snapshot.docs.isNotEmpty) {
        String passwordFromDb = snapshot.docs[0].get('password');
        if (passwordFromDb == password) {
          final userCredential = UserCredentialModel(
              username: username, roleId: snapshot.docs[0].get('roleId'));
          authPreferenceHelper.setUserData(userCredential);
          return userCredential;
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  //! Get User Credential
  @override
  Future<UserCredentialModel?> getUserCredential() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      if (credential != null) {
        QuerySnapshot snapshot = await userCollectionRef
            .where("username", isEqualTo: credential.username)
            .get();
        if (snapshot.docs.isNotEmpty) {
          return credential;
        } else {
          throw Exception();
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception();
    }
  }

  //! Logout
  @override
  Future<bool> logOut() {
    try {
      return authPreferenceHelper.removeUserData();
    } catch (e) {
      throw Exception();
    }
  }

  //! Delete User
  @override
  Future<bool> deleteUser({required String username}) async {
    try {
      QuerySnapshot querySnapshot =
          await userCollectionRef.where("username", isEqualTo: username).get();
      String uid = querySnapshot.docs.first.id;
      return await userCollectionRef
          .doc(uid)
          .delete()
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception();
    }
  }
}
