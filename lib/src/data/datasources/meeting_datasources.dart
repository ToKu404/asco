import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MeetingDataSources {
  Future<bool> create({
    required DetailMeetingModel meeting,
  });
  Future<DetailMeetingModel> single({required String uid});
  Future<List<DetailMeetingModel>> find({
    String? classroomUid,
  });
}

class MeetingDataSourceImpl implements MeetingDataSources {
  final FirebaseFirestore firestore;
  MeetingDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('meetings');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required DetailMeetingModel meeting}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = DetailMeetingModel(
          assistant1: meeting.assistant1,
          meetingDate: meeting.meetingDate,
          assistant2: meeting.assistant2,
          classUid: meeting.classUid,
          modulPath: meeting.modulPath,
          topic: meeting.topic,
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
      //       DetailMeetingModel(
      //         assistant1: meeting.assistant1,
      //         meetingDate: meeting.meetingDate,
      //         assistant2: meeting.assistant2,
      //         classUid: meeting.classUid,
      //         modulPath: meeting.modulPath,
      //         topic: meeting.topic,
      //         uid: uid,
      //       ),
      //     )
      //     .then((value) => true)
      //     .catchError((error) => false);
      // return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<DetailMeetingModel>> find({String? classroomUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      if (classroomUid != null) {
        if (classroomUid.isNotEmpty) {
          snapshot = collectionReference
              .where('classroom_uid', isEqualTo: classroomUid)
              .get();
        }
      }

      //? all
      return await snapshot.then(
        (value) => value.docs
            .map(
              (e) => DetailMeetingModel.fromSnapshot(e),
            )
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<DetailMeetingModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return DetailMeetingModel.fromSnapshot(documentSnapshot);
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
