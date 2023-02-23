import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReferenceHelper {
  static Future<List<ProfileEntity>> referenceProfiles(
      List<dynamic> studentRefs) async {
    try {
      //
      List<ProfileEntity> users = [];
      List<DocumentReference<Object?>> documentReferences = [];
      for (var item in studentRefs) {
        if (item is DocumentReference<Object?>) {
          documentReferences.add(item);
        }
      }
      for (DocumentReference userRef in documentReferences) {
        DocumentSnapshot userSnapshot = await userRef.get();
        if (userSnapshot.exists) {
          Map<String, dynamic> dataMap = {};

          if (userSnapshot.exists &&
              userSnapshot.data() != null &&
              userSnapshot.data() is Map<String, dynamic>) {
            (userSnapshot.data() as Map<String, dynamic>).forEach((key, value) {
              dataMap[key] = value;
            });
          }
          ProfileEntity user = ProfileModel.fromMap(dataMap);
          users.add(user);
        }
      }
      return users;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<ProfileEntity> referenceSingleProfile(
      dynamic studentRefs) async {
    try {
      //
      return await studentRefs.get().then((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          return ProfileModel.fromMap(data);
        } else {
          print('Dokumen tidak ditemukan');
        }
      }).catchError((error) {
        print('Terjadi kesalahan: $error');
      });
    } catch (e) {
      throw Exception();
    }
  }
}
