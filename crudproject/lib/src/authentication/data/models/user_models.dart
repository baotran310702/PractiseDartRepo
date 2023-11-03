import 'dart:convert';

import 'package:crudproject/core/utils/typedef.dart';
import 'package:crudproject/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdAt,
      required super.name,
      required super.avatar});

  UserModel copyModel(
      {String? avatar, String? id, String? createdAt, String? name}) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
            avatar: map['avatar'].toString(),
            id: map['id'].toString(),
            createdAt: map['createAt'].toString(),
            name: map['name'].toString());

  DataMap toMap() =>
      {'id': id, 'avatar': avatar, 'createAt': createdAt, 'name': name};

  String toJson() => jsonEncode(toMap());
}
