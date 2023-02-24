import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PracticumModel extends PracticumEntity {
  const PracticumModel({
    super.badgePath,
    super.course,
    super.courseContractPath,
    super.listAssistant,
    super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'badge_path': badgePath,
      'course': course,
      'course_contract_path': courseContractPath,
      'uid': uid,
    };
  }

  PracticumEntity toEntity() {
    return PracticumEntity(
      badgePath: badgePath,
      course: course,
      courseContractPath: courseContractPath,
      listAssistant: listAssistant,
      uid: uid,
    );
  }

  factory PracticumModel.fromSnapshot(
      DocumentSnapshot documentSnapshot, List<ProfileEntity> users) {
    return PracticumModel(
      badgePath: documentSnapshot.get('badge_path'),
      course: documentSnapshot['course'],
      courseContractPath: documentSnapshot.get('course_contract_path'),
      listAssistant: users,
      uid: documentSnapshot['uid'],
    );
  }

  factory PracticumModel.fromEntity(PracticumEntity entity) {
    return PracticumModel(
      badgePath: entity.badgePath,
      course: entity.course,
      courseContractPath: entity.courseContractPath,
      listAssistant: entity.listAssistant,
      uid: entity.uid,
    );
  }
}
