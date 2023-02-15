import 'package:asco/src/data/datasources/helpers/update_helper.dart';
import 'package:asco/src/data/models/profile_models/user_profile_model.dart';
import 'package:asco/src/data/services/preferences_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileDataSource {
  Future<bool> create({required UserProfileModel userProfileModel});
  Future<UserProfileModel> single({required String uid});
  Future<bool> update({required UserProfileModel userProfileModel});
  Future<bool> remove({required String uid});
  Future<List<UserProfileModel>> find();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final AuthPreferenceHelper authPreferenceHelper;

  ProfileDataSourceImpl(
      {required this.firestore, required this.authPreferenceHelper}) {
    collectionReference = firestore.collection('profiles');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required UserProfileModel userProfileModel}) async {
    try {
      QuerySnapshot snapshot = await collectionReference
          .where("username", isEqualTo: userProfileModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return false;
      } else {
        final id = collectionReference.doc().id;
        return collectionReference
            .add(UserProfileModel(
              uid: id,
              classOff: userProfileModel.classOff,
              fullName: userProfileModel.fullName,
              gender: userProfileModel.gender,
              github: userProfileModel.github,
              instagram: userProfileModel.instagram,
              nickName: userProfileModel.nickName,
              profilePhoto: userProfileModel.profilePhoto,
              username: userProfileModel.username,
            ).toDocument())
            .then((value) => true)
            .catchError((error) => false);
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<UserProfileModel>> find() async {
    try {
      final List<UserProfileModel> listUserProfile = [];
      await collectionReference.get().then((value) => {
            value.docs.forEach((element) {
              listUserProfile.add(
                UserProfileModel.fromSnapshot(element),
              );
            }),
          });
      return listUserProfile;
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
  Future<UserProfileModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return UserProfileModel.fromSnapshot(documentSnapshot);
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
  Future<bool> update({required UserProfileModel userProfileModel}) async {
    try {
      UpdateHelper updateHelper = UpdateHelper();
      updateHelper.onUpdate('class_of', userProfileModel.classOff);
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
}
