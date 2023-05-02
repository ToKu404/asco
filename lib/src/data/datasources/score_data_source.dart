import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/models.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ScoreDataSource {
  Future<List<ScoreEntity>> multiple({required List<String> multipleId});
  Future<bool> update({
    required String uid,
    required ScoreModel score,
  });
}

class ScoreDataSourceImpl implements ScoreDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  ScoreDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('scores');
  }

  @override
  Future<List<ScoreEntity>> multiple({required List<String> multipleId}) async {
    try {
      final snapshot =
          collectionReference.where('studentId', whereIn: multipleId).get();
      return await snapshot.then((value) async {
        final listData = <ScoreEntity>[];
        for (var data in value.docs) {
          final studentData = ScoreModel.fromSnapshot(
            data,
          );
          listData.add(studentData);
        }
        return listData;
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> update({required String uid, required ScoreModel score}) {
    try {
      return collectionReference
          .doc(uid)
          .update(score.toDocument())
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
