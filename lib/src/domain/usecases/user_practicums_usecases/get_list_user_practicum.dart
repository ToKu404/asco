// import 'package:asco/core/utils/failure.dart';
// import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
// import 'package:asco/src/domain/entities/user_practicum_entities/user_practicum_entity.dart';
// import 'package:asco/src/domain/repositories/user_practicum_repository.dart';
// import 'package:dartz/dartz.dart';

// class GetListUserPracticum {
//   final UserPracticumRepository repository;

//   GetListUserPracticum({required this.repository});

//   Future<Either<Failure, List<UserPracticumEntity>>> execute({
//     String? classroomUid,
//     String? groupUid,
//     String? practicumUid,
//   }) {
//     return repository.find(
//       classroomUid: classroomUid,
//       groupUid: groupUid,
//       practicumUid: practicumUid,
//     );
//   }
// }
