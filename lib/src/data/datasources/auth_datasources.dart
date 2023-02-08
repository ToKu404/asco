import 'package:asco/src/data/models/auth_models/user_credential.dart';
import 'package:asco/src/data/models/auth_models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthDataSources {
  Future<bool> createUser({required UserModel userModel});
  Future<UserCredentialModel> logIn(
      {required String username, required String password});
}

class AuthDataSourcesImpl implements AuthDataSources {
  final FirebaseFirestore firestore;
  AuthDataSourcesImpl({required this.firestore});

  //! Membuat User baru di firebase
  @override
  Future<bool> createUser({required UserModel userModel}) async {
    try {
      final userCollectionRef = firestore.collection('users');
      QuerySnapshot snapshot = await userCollectionRef
          .where("username", isEqualTo: userModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('username sudah digunakan');
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
      final userCollectionRef = firestore.collection('users');
      QuerySnapshot snapshot =
          await userCollectionRef.where("username", isEqualTo: username).get();
      print('disini5');

      if (snapshot.docs.isNotEmpty) {
        print('disini4');

        String passwordFromDb = snapshot.docs[0].get('password');
        if (passwordFromDb == password) {
          print('disini3');

          return UserCredentialModel(
              username: username, roleId: snapshot.docs[0].get('roleId'));
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print('disini2');

      print(e.toString());
      throw Exception();
    }
  }
}
