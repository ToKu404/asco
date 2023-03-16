import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int roleId;
  final String username;
  final String password;

  const UserEntity({
    required this.roleId,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
        roleId,
        username,
        password,
      ];
}
