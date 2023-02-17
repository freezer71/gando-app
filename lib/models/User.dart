

class User {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? nextEmail;
  final String? registrationDate;
  final String? accountType;
  final String? status;
  final String? loginType;
  final String? facebookId;
  final bool? isUserValidated;
  final List<String>? car;
  final String? phone;
  final String? nextPhone;
  final int? v;
  final String? dayOfBirth;
  final String? birthplace;
  final Address? address;
  final String? civility;
  final bool? askingForValidation;
  final List<dynamic>? favouriteCar;
  final int? money;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.nextEmail,
    this.registrationDate,
    this.accountType,
    this.status,
    this.loginType,
    this.facebookId,
    this.isUserValidated,
    this.car,
    this.phone,
    this.nextPhone,
    this.v,
    this.dayOfBirth,
    this.birthplace,
    this.address,
    this.civility,
    this.askingForValidation,
    this.favouriteCar,
    this.money,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        email = json['email'] as String?,
        nextEmail = json['nextEmail'] as String?,
        registrationDate = json['registrationDate'] as String?,
        accountType = json['accountType'] as String?,
        status = json['status'] as String?,
        loginType = json['loginType'] as String?,
        facebookId = json['facebookId'] as String?,
        isUserValidated = json['isUserValidated'] as bool?,
        car = (json['car'] as List?)?.map((dynamic e) => e as String).toList(),
        phone = json['phone'] as String?,
        nextPhone = json['nextPhone'] as String?,
        v = json['__v'] as int?,
        dayOfBirth = json['dayOfBirth'] as String?,
        birthplace = json['birthplace'] as String?,
        address = (json['address'] as Map<String,dynamic>?) != null ? Address.fromJson(json['address'] as Map<String,dynamic>) : null,
        civility = json['civility'] as String?,
        askingForValidation = json['askingForValidation'] as bool?,
        favouriteCar = json['favouriteCar'] as List?,
        money = json['money'] as int?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'firstname' : firstname,
    'lastname' : lastname,
    'email' : email,
    'nextEmail' : nextEmail,
    'registrationDate' : registrationDate,
    'accountType' : accountType,
    'status' : status,
    'loginType' : loginType,
    'facebookId' : facebookId,
    'isUserValidated' : isUserValidated,
    'car' : car,
    'phone' : phone,
    'nextPhone' : nextPhone,
    '__v' : v,
    'dayOfBirth' : dayOfBirth,
    'birthplace' : birthplace,
    'address' : address?.toJson(),
    'civility' : civility,
    'askingForValidation' : askingForValidation,
    'favouriteCar' : favouriteCar,
    'money' : money
  };
}

class Address {
  final String? addresse;
  final String? complement;
  final String? country;
  final String? city;
  final String? zipCode;
  final String? id;

  Address({
    this.addresse,
    this.complement,
    this.country,
    this.city,
    this.zipCode,
    this.id,
  });

  Address.fromJson(Map<String, dynamic> json)
      : addresse = json['addresse'] as String?,
        complement = json['complement'] as String?,
        country = json['country'] as String?,
        city = json['city'] as String?,
        zipCode = json['zipCode'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'addresse' : addresse,
    'complement' : complement,
    'country' : country,
    'city' : city,
    'zipCode' : zipCode,
    '_id' : id
  };
}