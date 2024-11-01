class UserModel {
  final String name;
  final String email;
  final String password;
  final String hobby;
  final int wallet;
  final String createBy;
  final DateTime createAt;
  final String updateBy;
  final DateTime updateAt;

  UserModel({
    this.name = "",
    this.password = "",
    this.email = "",
    this.hobby = "",
    this.wallet = 0,
    this.createBy = "",
    DateTime? createAt,
    this.updateBy = "",
    DateTime? updateAt,
  })  : createAt = createAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();
}
