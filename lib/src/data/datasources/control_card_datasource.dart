import 'package:asco/src/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';

abstract class ControlCardDataSource {
  Future<bool> initForStudent({
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
    required String practicumUid,
  });
  Future<ControlCardModel> single({required String uid});
  Future<List<ControlCardModel>> find({String? studentId});
}

class ControlCardDataSourceImpl implements ControlCardDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  ControlCardDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('control_cards');
  }

  @override
  Future<bool> initForStudent({
    List<String>? addedStudentId,
    List<String>? removeStudentId,
    String? practicumUid,
  }) async {
    try {
      for (String sId in addedStudentId!) {
        final snapshot =
            await collectionReference.where('student_id', isEqualTo: sId).get();
        if (snapshot.docs.isEmpty) {
          final uid = collectionReference.doc().id;
          collectionReference.doc(uid).get().then((value) {
            if (!value.exists) {
              collectionReference.doc(uid).set({
                "uid": uid,
                "student_id": sId,
                "student": firestore.collection('profiles').doc(sId),
                "practicum_uid": practicumUid,
                "data": List.generate(
                  16,
                  (index) => const ControlCardModel(
                          assistance1: null, assistance2: null, meeting: null)
                      .toDocument(),
                ),
              });
            }
          }).catchError((e) => throw FirestoreException(e.toString()));
        }
      }
      return true;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<ControlCardModel> single({required String uid}) async {
    try {
      return await collectionReference.doc(uid).get().then(
        (documentSnapshot) {
          if (documentSnapshot.exists) {
            return ControlCardModel.fromSnapshot(documentSnapshot);
          } else {
            throw FirestoreException('document is not exists.');
          }
        },
      );
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<ControlCardModel>> find({String? studentId}) async {
    try {
      final snapshot =
          collectionReference.where('student_id', isEqualTo: studentId).get();

      return await snapshot.then((value) {
        return value.docs
            .map((snapshot) => ControlCardModel.fromSnapshot(snapshot))
            .toList();
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
