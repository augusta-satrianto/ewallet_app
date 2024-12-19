class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? profilePicture;
  final int? balance;
  final String? cardNumber;
  final String? pin;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.profilePicture,
    this.balance,
    this.cardNumber,
    this.pin,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      balance: json['balance'],
      cardNumber: json['card_number'],
      pin: json['pin'],
      token: json['token']);

  UserModel copyWith(
          {String? username,
          String? name,
          String? email,
          String? pin,
          String? password,
          int? balance}) =>
      UserModel(
          id: id,
          name: name ?? this.name,
          email: email ?? this.email,
          pin: pin ?? this.pin,
          password: password ?? this.password,
          balance: balance ?? this.balance,
          profilePicture: profilePicture,
          cardNumber: cardNumber,
          token: token);
}
