class User {
  String firstName;
  String lastName;
  String studentID;
  String studentEmail;
  String userName;
  String passwordHash;

  User({
    required this.firstName,
    required this.lastName,
    required this.studentID,
    required this.studentEmail,
    required this.userName,
    required this.passwordHash,
  });

  String getFullName() {
    return "$firstName $lastName";
  }
}
