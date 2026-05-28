import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 1)
class AuthModel {

  @HiveField(0)
  bool isLoggedIn;

  @HiveField(1)
  String email;

  AuthModel({
    required this.isLoggedIn,
    required this.email,
  });
}