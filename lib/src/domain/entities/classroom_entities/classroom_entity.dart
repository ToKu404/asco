import 'package:equatable/equatable.dart';

class ClassroomEntity extends Equatable {
  final String? uid;
  final String? meetingDay;
  final int? startTime;
  final int? endTime;

  const ClassroomEntity({
    this.startTime,
    this.endTime,
    this.meetingDay,
    this.uid,
  });

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        meetingDay,
        uid,
      ];
}
