import 'package:equatable/equatable.dart';

class UserCredentialEntity extends Equatable {
  final String username;
  final int roleId;

  const UserCredentialEntity({
    required this.username,
    required this.roleId,
  });

  @override
  List<Object?> get props => [
        username,
        roleId,
      ];
}
