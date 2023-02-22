import 'package:asco/src/data/models/practicum_models/practicum_model.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class PracticumDataSource {
  Future<bool> create({required PracticumModel practicum});
  Future<PracticumModel> single({required String uid});
  Future<bool> updateAssistant({
    required List<ProfileEntity> assistants,
    required String practicumUid,
  });
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
        (error, stackTrace) {
          print(error.toString());
          throw Exception();
        },
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
      print(e.toString());
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
      debugPrint(e.toString());
      throw Exception();
    }
  }

  @override
  Future<PracticumModel> single({required String uid}) async {
    try {
      return await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return PracticumModel.fromSnapshot(documentSnapshot);
        } else {
          throw Exception();
        }
      });
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateAssistant(
      {required List<ProfileEntity> assistants,
      required String practicumUid}) async {
    try {
      collectionReference
          .doc(practicumUid)
          .update({
            "list_assistant": assistants
                .map(
                  (e) => ProfileModel.fromEntity(e).toDocument(),
                )
                .toList()
          })
          .then((value) => true)
          .catchError((e) => false);

      return false;
    } catch (e) {
      debugPrint(e.toString());

      throw Exception();
    }
  }
}
