// import 'package:asco/core/utils/failure.dart';
// import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
// import 'package:asco/src/domain/repositories/attendances_repository.dart';
// import 'package:dartz/dartz.dart';

// class UpdateAttendance {
//   final AttendancesRepository repository;

//   UpdateAttendance({required this.repository});

//   Future<Either<Failure, bool>> execute({
//     required String uid,
//     required AttendanceEntity attendance,
//     required AttendanceEntity oldAttendance,
//   }) {
//     return repository.update(
//       attendance: attendance,
//       oldAttendance: oldAttendance,
//       uid: uid,
//     );
//   }
// }
