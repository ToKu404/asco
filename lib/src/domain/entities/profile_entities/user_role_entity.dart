import 'package:equatable/equatable.dart';

class UserRoleEntity extends Equatable {
  final int? id;
  final String? name;

  const UserRoleEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
