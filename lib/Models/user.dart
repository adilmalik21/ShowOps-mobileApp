class User {
  final String status;
  final String message;
  final UserDetails? userDetails;

  User({required this.status, required this.message, this.userDetails});

  factory User.fromJson(Map<String, dynamic> json) {
    UserDetails? userDetails;
    if (json.containsKey('data')) {
      userDetails = UserDetails.fromJson(json['data']);
    }
    return User(
      status: json['status'],
      message: json['message'],
      userDetails: userDetails,
    );
  }

  @override
  String toString() {
    return 'Status: $status, Message: $message, UserDetails: $userDetails';
  }
}

class UserDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int accountId;
  final int organiserId;
  final String organiserName;
  final String userType;
  final String token;

  UserDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accountId,
    required this.organiserId,
    required this.organiserName,
    required this.userType,
    required this.token,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      accountId: json['account_id'],
      organiserId: json['organiser_id'],
      organiserName: json['organiser_name'],
      userType: json['user_type'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return 'ID: $id, First Name: $firstName, Last Name: $lastName, Email: $email, Account ID: $accountId, Organiser ID: $organiserId, Organiser Name: $organiserName, User Type: $userType, Token: $token';
  }
}
