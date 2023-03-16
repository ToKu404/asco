import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class AssistanceGroupEntity extends Equatable {
  final String? uid;
  final String? practicumUid;
  final String? name;
  final ProfileEntity? assistant;
  final List<ProfileEntity>? students;

  const AssistanceGroupEntity({
    this.uid,
    this.practicumUid,
    this.name,
    this.assistant,
    this.students,
  });

  @override
  List<Object?> get props => [
        uid,
        practicumUid,
        name,
        assistant,
        students,
      ];
}
