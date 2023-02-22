import 'package:asco/src/data/models/assistance_models/assistance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AssistanceGroupDataSources {
  Future<bool> create({
    required AssistanceGroupModel entity,
  });
  Future<AssistanceGroupModel> single(
      {required String uuid, String? assistant});
  Future<List<AssistanceGroupModel>> find({
    required String practicumUid,
  });
}

class AttendancesDataSourceImpl implements AssistanceGroupDataSources {
  final FirebaseFirestore firestore;
  AttendancesDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('assistance_groups');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required AssistanceGroupModel entity}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = AssistanceGroupModel(
          assistant: entity.assistant,
          name: entity.name,
          practicumUid: entity.practicumUid,
          students: entity.students,
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
      //       AssistanceGroupModel(
      //               assistant: entity.assistant,
      //               name: entity.name,
      //               practicumUid: entity.practicumUid,
      //               students: entity.students,
      //               uid: uid)
      //           .toDocument(),
      //     )
      //     .then((value) => true)
      //     .catchError((error) => false);
      // return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<AssistanceGroupModel>> find(
      {required String practicumUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where('practicum_uid', isEqualTo: practicumUid)
          .get();

      //? all
      return await snapshot.then(
        (value) => value.docs
            .map(
              (e) => AssistanceGroupModel.fromSnapshot(e),
            )
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<AssistanceGroupModel> single(
      {required String uuid, String? assistant}) async {
    try {
      // TODO: BY ASISTENT
      await collectionReference
          .doc(uuid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return AssistanceGroupModel.fromSnapshot(documentSnapshot);
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
