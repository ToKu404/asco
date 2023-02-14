import 'package:asco/src/data/models/profile_models/user_profile_model.dart';
import 'package:asco/src/data/services/preferences_services.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileDataSource {
  Future<bool> create({required UserProfileModel userProfileModel});
  Future<UserProfileEntity> single({required String username});
  Future<bool> update(
      {required UserProfileModel userProfileModel, required String uid});
  Future<bool> remove({required String uid});
  Future<List<UserProfileModel>> find();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final AuthPreferenceHelper authPreferenceHelper;

  ProfileDataSourceImpl(
      {required this.firestore, required this.authPreferenceHelper});

  @override
  Future<bool> create({required UserProfileModel userProfileModel}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<UserProfileModel>> find() {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<bool> remove({required String uid}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<UserProfileEntity> single({required String username}) {
    // TODO: implement single
    throw UnimplementedError();
  }

  @override
  Future<bool> update(
      {required UserProfileModel userProfileModel, required String uid}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
