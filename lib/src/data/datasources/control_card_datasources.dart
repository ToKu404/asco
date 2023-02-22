import 'package:asco/src/data/models/assistance_models/control_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ControlCardDataSources {
  Future<bool> create({
    required ControlCardModel cc,
  });
  Future<ControlCardModel> single({required String uid});
  Future<List<ControlCardModel>> find({
    String? studentId,
  });
}

class ControlCardDataSourcesImpl implements ControlCardDataSources {
  final FirebaseFirestore firestore;
  ControlCardDataSourcesImpl({required this.firestore}) {
    collectionReference = firestore.collection('control_cards');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required ControlCardModel cc}) async {
    try {
      final uid = collectionReference.doc().id;
      await collectionReference
          .add(
            ControlCardModel(
              assistance1: cc.assistance1,
              assistance2: cc.assistance2,
              meeting: cc.meeting,
              studentId: cc.studentId,
              uid: uid,
            ).toDocument(),
          )
          .then((value) => true)
          .catchError((error) => false);
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<ControlCardModel>> find({String? studentId}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot =
          collectionReference.where('student_id', isEqualTo: studentId).get();

      //? all
      return await snapshot.then(
        (value) => value.docs
            .map(
              (e) => ControlCardModel.fromSnapshot(e),
            )
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<ControlCardModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return ControlCardModel.fromSnapshot(documentSnapshot);
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
