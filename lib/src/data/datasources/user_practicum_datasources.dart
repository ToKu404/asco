// import 'dart:math';

// import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
// import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
// import 'package:asco/src/data/models/profile_models/profile_model.dart';
// import 'package:asco/src/data/models/user_practicums_model.dart/user_practicum_model.dart';
// import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
// import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
// import 'package:asco/src/domain/entities/user_practicum_entities/user_practicum_entity.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class UserPracticumDataSource {
//   Future<bool> set(
//       {required UserPracticumModel userPracticum,
//       required List<String> listStudentId});
//   Future<bool> delete({required String uuid});
//   Future<List<UserPracticumEntity>> find({
//     String? practicumUid,
//     String? groupUid,
//     String? classroomUid,
//   });
// }

// class UserPracticumDataSourceImpl implements UserPracticumDataSource {
//   final FirebaseFirestore firestore;
//   UserPracticumDataSourceImpl({required this.firestore}) {
//     collectionReference = firestore.collection('user_practicums');
//   }

//   late CollectionReference collectionReference;

//   @override
//   Future<bool> delete({required String uuid}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> set(
//       {required UserPracticumModel userPracticum,
//       required List<String> listStudentId}) async {
//     try {
//       for (String studentId in listStudentId) {
//         QuerySnapshot snapshot = await collectionReference
//             .where("user.$studentId", isEqualTo: userPracticum.user?.uid)
//             .where("practicum_uid", isEqualTo: userPracticum.practicumUid)
//             .get();
//         if (snapshot.docs.isNotEmpty) {
//           collectionReference
//               .doc(snapshot.docs.first.id)
//               .update({
//                 if (userPracticum.group != null)
//                   "group": firestore
//                       .collection('assistance_groups')
//                       .doc(userPracticum.group!.uid),
//                 if (userPracticum.classroom != null)
//                   "classroom": firestore
//                       .collection('classrooms')
//                       .doc(userPracticum.classroom!.uid)
//               })
//               .then((value) => true)
//               .catchError((e) => false);
//           return true;
//         } else {
//           final id = collectionReference.doc().id;
//           collectionReference.doc(id).get().then((value) {
//             if (!value.exists) {
//               collectionReference.doc(id).set({
//                 "uid": id,
//                 "user": firestore
//                     .collection('profiles')
//                     .doc(userPracticum.user!.uid),
//                 "practicum_uid": userPracticum.practicumUid,
//                 "group": userPracticum.group != null
//                     ? firestore
//                         .collection('assistance_groups')
//                         .doc(userPracticum.group!.uid)
//                     : null,
//                 "classroom": userPracticum.classroom != null
//                     ? firestore
//                         .collection('classrooms')
//                         .doc(userPracticum.classroom!.uid)
//                     : null,
//               });
//             }
//             return true;
//           }).catchError(
//             (error, stackTrace) => throw Exception(),
//           );
//           return false;
//         }
//       }
//       return true;
//     } catch (e) {
//       throw Exception();
//     }
//   }

//   @override
//   Future<List<UserPracticumEntity>> find(
//       {String? practicumUid, String? groupUid, String? classroomUid}) async {
//     Future<QuerySnapshot> snapshot = collectionReference.get();
//     if (groupUid != null) {
//       snapshot =
//           collectionReference.where('group.uid', isEqualTo: groupUid).get();
//     } else if (classroomUid != null) {
//       snapshot = collectionReference
//           .where('classrooms.uid', isEqualTo: groupUid)
//           .get();
//     } else if (practicumUid != null) {
//       snapshot = collectionReference
//           .where('practicum_uid', isEqualTo: practicumUid)
//           .get();
//     }
//     return await snapshot.then((value) async {
//       final List<UserPracticumEntity> listData = [];
//       for (var element in value.docs) {
//         listData.add(
//           UserPracticumModel.fromSnapshot(
//             uuid: element['uid'],
//             practicumUid: element['practicum_uid'],
//             user: element['user'] != null
//                 ? ProfileModel.fromMap(
//                     await ReferenceHelper.referenceSingleProfile<ProfileEntity>(
//                         element['user']))
//                 : null,
//             classroom: element['classroom'] != null
//                 ? ClassroomModel.fromMap(
//                     await ReferenceHelper.referenceSingleProfile<
//                         ClassroomEntity>(element['classroom']))
//                 : null,
//           ),
//         );
//       }
//       return listData;
//     });
//   }
// }
