class ChangePasswordRequestEntity {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequestEntity({
    required this.oldPassword,
    required this.newPassword,
  });
}
