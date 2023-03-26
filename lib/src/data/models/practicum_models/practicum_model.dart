import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class PracticumModel extends PracticumEntity {
  const PracticumModel({
    super.uid,
    super.badgePath,
    super.course,
    super.courseContractPath,
    super.listAssistant,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'badge_path': badgePath,
      'course': course,
      'course_contract_path': courseContractPath,
    };
  }

  PracticumEntity toEntity() {
    return PracticumEntity(
      uid: uid,
      badgePath: badgePath,
      course: course,
      courseContractPath: courseContractPath,
      listAssistant: listAssistant,
    );
  }

  factory PracticumModel.fromSnapshot(
    DocumentSnapshot documentSnapshot,
    List<ProfileEntity>? users,
  ) {
    return PracticumModel(
      uid: documentSnapshot['uid'],
      badgePath: documentSnapshot.get('badge_path'),
      course: documentSnapshot['course'],
      courseContractPath: documentSnapshot.get('course_contract_path'),
      listAssistant: users,
    );
  }

  factory PracticumModel.fromMap(
    Map<String, dynamic> documentSnapshot,
  ) {
    // List<dynamic> assistantList = documentSnapshot['list_assistant'] ?? [];
    // List<ProfileEntity> parsedAssistantList = assistantList
    //     .map((assistant) => ProfileModel.fromMap(assistant))
    //     .toList();
    final data = PracticumModel(
      uid: documentSnapshot['uid'],
      badgePath: documentSnapshot['badge_path'],
      course: documentSnapshot['course'],
      courseContractPath: documentSnapshot['course_contract_path'],
    );
    return data;
  }

  factory PracticumModel.fromEntity(PracticumEntity entity) {
    return PracticumModel(
      uid: entity.uid,
      badgePath: entity.badgePath,
      course: entity.course,
      courseContractPath: entity.courseContractPath,
      listAssistant: entity.listAssistant,
    );
  }
}
