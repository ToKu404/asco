import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';

abstract class ControlCardDataSource {
  Future<bool> create({required ControlCardModel controlCard});

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
  Future<bool> create({required ControlCardModel controlCard}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = ControlCardModel(
          assistance1: controlCard.assistance1,
          assistance2: controlCard.assistance2,
        );

        if (!value.exists) {
          collectionReference.doc(uid).set(data.toDocument());
        }

        return true;
      }).catchError((e) => throw FirestoreException(e.toString()));

      return false;
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
