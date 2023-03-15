import 'package:equatable/equatable.dart';

class AssistanceAttendanceEntity extends Equatable {
  final DateTime? assistanceDateTime;
  final String? status;
  final String? note;

  const AssistanceAttendanceEntity({
    this.assistanceDateTime,
    this.status,
    this.note,
  });

  @override
  List<Object?> get props => [
        assistanceDateTime,
        status,
        note,
      ];
}
