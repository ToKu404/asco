import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PracticumModel extends PracticumEntity {
  const PracticumModel({
    required super.badgePath,
    required super.classes,
    required super.course,
    required super.courseContractPath,
    required super.listAssistant,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'badge_path': badgePath,
      'classes': classes?.map(
        (e) => ClassroomModel.fromEntity(e).toDocument(),
      ),
      'course': course,
      'course_contract_path': courseContractPath,
      'list_assistant': listAssistant,
      'uid': uid,
    };
  }

  PracticumEntity toEntity() {
    return PracticumEntity(
      badgePath: badgePath,
      classes: classes,
      course: course,
      courseContractPath: courseContractPath,
      listAssistant: listAssistant,
      uid: uid,
    );
  }

  factory PracticumModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    // Iterable data = documentSnapshot['classess'] as List;
    return PracticumModel(
      badgePath: documentSnapshot['badge_path'],
      classes: List<ClassroomEntity>.from(
        documentSnapshot['classess'].map(
          (classroom) => ClassroomModel.fromMap(classroom),
        ),
      ),
      course: documentSnapshot['course'],
      courseContractPath: documentSnapshot['course_contract_path'],
      listAssistant: documentSnapshot['list_assistant'],
      uid: documentSnapshot['uid'],
    );
  }

  factory PracticumModel.fromEntity(PracticumEntity entity) {
    return PracticumModel(
      badgePath: entity.badgePath,
      classes: entity.classes,
      course: entity.course,
      courseContractPath: entity.courseContractPath,
      listAssistant: entity.listAssistant,
      uid: entity.uid,
    );
  }
}
