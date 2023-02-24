// import 'package:asco/src/data/datasources/user_practicum_datasources.dart';
// import 'package:asco/src/data/datasources/user_practicum_datasources.dart';
// import 'package:asco/src/data/models/user_practicums_model.dart/user_practicum_model.dart';
// import 'package:asco/src/domain/entities/user_practicum_entities/user_practicum_entity.dart';
// import 'package:asco/core/utils/failure.dart';
// import 'package:asco/src/domain/repositories/user_practicum_repository.dart';
// import 'package:dartz/dartz.dart';

// class UserPracticumRepositoryImpl implements UserPracticumRepository {
//   final UserPracticumDataSource datasource;

//   UserPracticumRepositoryImpl({required this.datasource});

//   @override
//   Future<Either<Failure, bool>> set(
//       {required UserPracticumEntity userPracticum,
//       required List<String> listStudentId}) async {
//     try {
//       final result = await datasource.set(
//           userPracticum: UserPracticumModel.fromEntity(userPracticum), listStudentId: listStudentId);
//       return Right(result);
//     } catch (e) {
//       return const Left(FirestoreFailure(''));
//     }
//   }

//   @override
//   Future<Either<Failure, List<UserPracticumEntity>>> find(
//       {String? practicumUid, String? groupUid, String? classroomUid}) async {
//     try {
//       final result = await datasource.find(
//         classroomUid: classroomUid,
//         groupUid: groupUid,
//         practicumUid: practicumUid,
//       );

//       return Right(result);
//     } catch (e) {
//       return const Left(FirestoreFailure(''));
//     }
//   }
// }
