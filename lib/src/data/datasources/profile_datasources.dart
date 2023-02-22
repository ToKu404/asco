import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/profile_models/detail_profile_model.dart';
import 'package:asco/src/data/services/preferences_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileDataSource {
  Future<bool> create({required DetailProfileModel userProfileModel});
  Future<DetailProfileModel> single({required String uid});
  Future<DetailProfileModel> me();
  Future<List<DetailProfileModel>> multiple({
    required List<String> multipleId,
  });
  Future<bool> update({required DetailProfileModel userProfileModel});
  Future<bool> remove({required String uid});
  Future<List<DetailProfileModel>> find({
    String? query,
    int? byRole,
  });
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final AuthPreferenceHelper pref;

  ProfileDataSourceImpl({required this.firestore, required this.pref}) {
    collectionReference = firestore.collection('profiles');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required DetailProfileModel userProfileModel}) async {
    try {
      QuerySnapshot snapshot = await collectionReference
          .where("username", isEqualTo: userProfileModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return false;
      } else {
        final id = collectionReference.doc().id;

        collectionReference.doc(id).get().then((value) {
          final data = DetailProfileModel(
            uid: id,
            classOf: userProfileModel.classOf,
            fullName: userProfileModel.fullName,
            gender: userProfileModel.gender,
            github: userProfileModel.github,
            instagram: userProfileModel.instagram,
            nickName: userProfileModel.nickName,
            profilePhoto: userProfileModel.profilePhoto,
            username: userProfileModel.username,
            userRole: userProfileModel.userRole,
          );
          if (!value.exists) {
            collectionReference.doc(id).set(
                  data.toDocument(),
                );
          }
          return true;
        }).catchError(
          (error, stackTrace) => throw Exception(),
        );
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<List<DetailProfileModel>> find({
    String? query,
    int? byRole,
  }) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();
      // Todo : Finish Search
      if (query != null) {
        if (query.isNotEmpty) {
          snapshot =
              collectionReference.where('username', isEqualTo: query).get();
        }
      }

      //? by Role
      if (byRole != null) {
        snapshot =
            collectionReference.where('role.id', isEqualTo: byRole).get();
      }

      //? all
      return await snapshot.then(
        (value) =>
            value.docs.map((e) => DetailProfileModel.fromSnapshot(e)).toList(),
      );
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<DetailProfileModel>> multiple({
    required List<String> multipleId,
  }) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where(
            'uid',
            whereIn: multipleId,
          )
          .get();

      return await snapshot.then(
        (value) =>
            value.docs.map((e) => DetailProfileModel.fromSnapshot(e)).toList(),
      );
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> remove({required String uid}) async {
    try {
      return await collectionReference
          .doc(uid)
          .delete()
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailProfileModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return DetailProfileModel.fromSnapshot(documentSnapshot);
        } else {
          throw Exception();
        }
      });
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> update({required DetailProfileModel userProfileModel}) async {
    try {
      UpdateHelper updateHelper = UpdateHelper();
      updateHelper.onUpdate('class_of', userProfileModel.classOf);
      updateHelper.onUpdate('full_name', userProfileModel.fullName);
      updateHelper.onUpdate('gender', userProfileModel.gender);
      updateHelper.onUpdate('github', userProfileModel.github);
      updateHelper.onUpdate('username', userProfileModel.username);
      updateHelper.onUpdate('instagram', userProfileModel.instagram);
      updateHelper.onUpdate('nick_name', userProfileModel.nickName);
      updateHelper.onUpdate('profile_photo', userProfileModel.profilePhoto);

      return await collectionReference
          .doc(userProfileModel.uid)
          .update(updateHelper.map)
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailProfileModel> me() async {
    try {
      final credential = await pref.getUser();

      QuerySnapshot snapshot = await collectionReference
          .where("username", isEqualTo: credential!.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return DetailProfileModel.fromSnapshot(snapshot.docs.first);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
