import 'package:equatable/equatable.dart';

class UserCredentialEntity extends Equatable {
  final int roleId;
  final String username;

  const UserCredentialEntity({
    required this.roleId,
    required this.username,
  });

  @override
  List<Object?> get props => [
        roleId,
        username,
      ];
}
