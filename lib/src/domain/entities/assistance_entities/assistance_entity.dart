import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:equatable/equatable.dart';

class AssistanceEntity extends Equatable {
  final String? uid;
  final String? practicumUid;
  final String? name;
  final DetailProfileEntity? assistant;
  final List<DetailProfileEntity>? students;

  const AssistanceEntity({
    this.assistant,
    this.name,
    this.practicumUid,
    this.students,
    this.uid,
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
