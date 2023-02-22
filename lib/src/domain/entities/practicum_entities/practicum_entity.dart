import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class PracticumEntity extends Equatable {
  final String? uid;
  final String? badgePath;
  final String? course;
  final String? courseContractPath;
  final List<ProfileEntity>? listAssistant;

  const PracticumEntity({
    this.badgePath,
    this.course,
    this.courseContractPath,
    this.listAssistant,
    this.uid,
  });

  @override
  List<Object?> get props => [
        badgePath,
        course,
        courseContractPath,
        listAssistant,
        uid,
      ];
}
