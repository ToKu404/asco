import 'package:equatable/equatable.dart';

class MeetingEntity extends Equatable {
  final String? uid;

  final String? topic;
  final DateTime? meetingDate;

  const MeetingEntity({
    this.meetingDate,
    this.topic,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        meetingDate,
        topic,
      ];
}
