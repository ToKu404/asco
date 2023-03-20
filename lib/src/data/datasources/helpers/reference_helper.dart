import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class ReferenceHelper {
  static Future<List<ProfileEntity>> referenceProfiles(
      List<dynamic> studentRefs) async {
    try {
      final documentReferences = <DocumentReference<Object?>>[];
      final users = <ProfileEntity>[];

      for (var item in studentRefs) {
        if (item is DocumentReference<Object?>) {
          documentReferences.add(item);
        }
      }

      for (var userRef in documentReferences) {
        final userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          final dataMap = <String, dynamic>{};

          if (userSnapshot.data() != null) {
            if (userSnapshot.data() is Map<String, dynamic>) {
              (userSnapshot.data() as Map<String, dynamic>).forEach(
                (key, value) => dataMap[key] = value,
              );
            }
          }

          final user = ProfileModel.fromMap(dataMap);

          users.add(user);
        }
      }

      return users;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  static Future<Map<String, dynamic>> referenceSingle<T>(
      dynamic studentRef) async {
    try {
      final referenceData = await studentRef.get().then((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;

          return data;
        }
      }).catchError((_) => <String, dynamic>{});

      final referenceDataMap = referenceData as Map<String, dynamic>;

      return referenceDataMap;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
