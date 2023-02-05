import 'package:asco/src/data/models/auth_models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthDataSources {
  Future<bool> createUser({required UserModel userModel});
}

class AuthDataSourcesImpl implements AuthDataSources {
  final FirebaseFirestore firestore;
  AuthDataSourcesImpl({required this.firestore});


  //! Membuat User baru di firebase 
  @override
  Future<bool> createUser({required UserModel userModel}) async {
    try {
      final userCollectionRef = firestore.collection('users');
      final uid = userCollectionRef.doc().id;
      firestore.doc(uid).get().then((value) {
        final newUser = userModel.toDocument();
        if (!value.exists) {
          userCollectionRef.doc(uid).set(newUser);
        }
        return true;
      });
    } catch (e) {
      throw Exception();
    }
    return false;
  }
}
