

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? nextEmail;
  final String? registrationDate;
  final String? typeOfAccount;
  final String? status;
  final String? loginType;
  final CarteBancaire? carteBancaire;
  final String? facebookId;
  final bool? isUserValidated;
  final List<dynamic>? voitures;
  final String? phone;
  final String? nextPhone;
  final int? v;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.nextEmail,
    this.registrationDate,
    this.typeOfAccount,
    this.status,
    this.loginType,
    this.carteBancaire,
    this.facebookId,
    this.isUserValidated,
    this.voitures,
    this.phone,
    this.nextPhone,
    this.v,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        email = json['email'] as String?,
        nextEmail = json['nextEmail'] as String?,
        registrationDate = json['registration_Date'] as String?,
        typeOfAccount = json['type_of_account'] as String?,
        status = json['status'] as String?,
        loginType = json['loginType'] as String?,
        carteBancaire = (json['carteBancaire'] as Map<String,dynamic>?) != null ? CarteBancaire.fromJson(json['carteBancaire'] as Map<String,dynamic>) : null,
        facebookId = json['facebookId'] as String?,
        isUserValidated = json['isUserValidated'] as bool?,
        voitures = json['voitures'] as List?,
        phone = json['phone'] as String?,
        nextPhone = json['nextPhone'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email' : email,
    'nextEmail' : nextEmail,
    'registration_Date' : registrationDate,
    'type_of_account' : typeOfAccount,
    'status' : status,
    'loginType' : loginType,
    'carteBancaire' : carteBancaire?.toJson(),
    'facebookId' : facebookId,
    'isUserValidated' : isUserValidated,
    'voitures' : voitures,
    'phone' : phone,
    'nextPhone' : nextPhone,
    '__v' : v
  };
}

class CarteBancaire {
  final String? dateExpiration;
  final String? numero;
  final String? cryptogramme;
  final String? id;

  CarteBancaire({
    this.dateExpiration,
    this.numero,
    this.cryptogramme,
    this.id,
  });

  CarteBancaire.fromJson(Map<String, dynamic> json)
      : dateExpiration = json['dateExpiration'] as String?,
        numero = json['numero'] as String?,
        cryptogramme = json['cryptogramme'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'dateExpiration' : dateExpiration,
    'numero' : numero,
    'cryptogramme' : cryptogramme,
    '_id' : id
  };
}