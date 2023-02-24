// import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
// import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
// import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
// import 'package:asco/src/domain/entities/user_practicum_entities/user_practicum_entity.dart';

// class UserPracticumModel extends UserPracticumEntity {
//   const UserPracticumModel({
//     super.classroom,
//     super.group,
//     super.practicumUid,
//     super.user,
//     super.uuid,
//   });

//   UserPracticumEntity toEntity() {
//     return UserPracticumEntity(
//       classroom: classroom,
//       group: group,
//       practicumUid: practicumUid,
//       user: user,
//       uuid: uuid,
//     );
//   }

//   factory UserPracticumModel.fromSnapshot(
//       {String? practicumUid,
//       ProfileEntity? user,
//       String? uuid,
//       AssistanceGroupEntity? group,
//       ClassroomEntity? classroom}) {
//     return UserPracticumModel(
//       classroom: classroom,
//       group: group,
//       practicumUid: practicumUid,
//       user: user,
//       uuid: uuid,
//     );
//   }

//   factory UserPracticumModel.fromEntity(UserPracticumEntity entity) {
//     return UserPracticumModel(
//       classroom: entity.classroom,
//       group: entity.group,
//       practicumUid: entity.practicumUid,
//       user: entity.user,
//       uuid: entity.uuid,
//     );
//   }
// }
