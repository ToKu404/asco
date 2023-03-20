import 'package:equatable/equatable.dart';

class UserPracticumHelper extends Equatable {
  final String? classroomUid;
  final String? groupUid;

  const UserPracticumHelper({this.classroomUid, this.groupUid});

  @override
  List<Object?> get props => [classroomUid, groupUid];
}
