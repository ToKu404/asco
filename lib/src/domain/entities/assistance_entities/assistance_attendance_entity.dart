import 'package:equatable/equatable.dart';

class AssistanceAttendanceEntity extends Equatable {
  final String? status;
  final DateTime? assistanceDateTime;
  final String? note;
  
  const AssistanceAttendanceEntity({
    this.status,
    this.assistanceDateTime,
    this.note,
  });

  @override
  List<Object?> get props => [
        status,
        assistanceDateTime,
        note,
      ];
}
