import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String password;
  final int roleId;

  const UserEntity({
    required this.username,
    required this.password,
    required this.roleId,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        roleId,
      ];
}
