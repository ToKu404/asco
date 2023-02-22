import 'package:asco/src/data/models/practicum_models/practicum_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PracticumDataSource {
  Future<bool> create({required PracticumModel practicum});
  Future<PracticumModel> single({required String uid});
  Future<List<PracticumModel>> find({
    String? query,
  });
}

class PracticumDataSourceImpl implements PracticumDataSource {
  final FirebaseFirestore firestore;
  PracticumDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('practicums');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required PracticumModel practicum}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = PracticumModel(
          badgePath: practicum.badgePath,
          course: practicum.course,
          courseContractPath: practicum.courseContractPath,
          listAssistant: practicum.listAssistant,
          uid: uid,
        );
        if (!value.exists) {
          collectionReference.doc(uid).set(
                data.toDocument(),
              );
        }
        return true;
      }).catchError(
        (error, stackTrace) => throw Exception(),
      );
      return false;

      // await collectionReference
      //     .add(
      //       PracticumModel(
      //         badgePath: practicum.badgePath,
      //         course: practicum.course,
      //         courseContractPath: practicum.courseContractPath,
      //         listAssistant: practicum.listAssistant,
      //         uid: uid,
      //       ).toDocument(),
      //     )
      //     .then((value) => true)
      //     .catchError((error) => false);
      // return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<PracticumModel>> find({
    String? query,
  }) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();
      // Todo : Finish Search
      if (query != null) {
        if (query.isNotEmpty) {
          snapshot =
              collectionReference.where('course', isEqualTo: query).get();
        }
      }

      //? all
      return await snapshot.then(
        (value) =>
            value.docs.map((e) => PracticumModel.fromSnapshot(e)).toList(),
      );
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<PracticumModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return PracticumModel.fromSnapshot(documentSnapshot);
        } else {
          throw Exception();
        }
      });
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
