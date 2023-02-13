class Car {
  final String? status;
  final String? id;
  final String? brand;
  final String? model;
  final String? type;
  final Location? location;
  final int? year;
  final int? mileage;
  final String? licensePlate;
  final String? gearbox;
  final String? fuel;
  final String? nextTechnicalInspection;
  final int? numberOfPlaces;
  final int? numberOfDoors;
  final int? note;
  final List<String>? equipment;
  final Owner? owner;
  final bool? isCreated;
  final Images? images;
  final List<dynamic>? disponibility;
  final int? creationStep;
  final int? pricePerDay;
  final int? pricePerWeek;
  final int? pricePerMonth;
  final bool? youngDriver;
  final String? city;
  final String? zipCode;
  final String? address;
  final String? description;
  final String? nextTechnicalInspectionImage;
  final List<Advice>? advice;
  final int? v;

  Car({
    this.status,
    this.id,
    this.brand,
    this.model,
    this.type,
    this.location,
    this.year,
    this.mileage,
    this.licensePlate,
    this.gearbox,
    this.fuel,
    this.nextTechnicalInspection,
    this.numberOfPlaces,
    this.numberOfDoors,
    this.note,
    this.equipment,
    this.owner,
    this.isCreated,
    this.images,
    this.disponibility,
    this.creationStep,
    this.pricePerDay,
    this.pricePerWeek,
    this.pricePerMonth,
    this.youngDriver,
    this.city,
    this.zipCode,
    this.address,
    this.description,
    this.nextTechnicalInspectionImage,
    this.advice,
    this.v,
  });

  Car.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        id = json['_id'] as String?,
        brand = json['brand'] as String?,
        model = json['model'] as String?,
        type = json['type'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        year = json['year'] as int?,
        mileage = json['mileage'] as int?,
        licensePlate = json['licensePlate'] as String?,
        gearbox = json['gearbox'] as String?,
        fuel = json['fuel'] as String?,
        nextTechnicalInspection = json['nextTechnicalInspection'] as String?,
        numberOfPlaces = json['numberOfPlaces'] as int?,
        numberOfDoors = json['numberOfDoors'] as int?,
        note = json['note'] as int?,
        equipment = (json['equipment'] as List?)?.map((dynamic e) => e as String).toList(),
        owner = (json['owner'] as Map<String,dynamic>?) != null ? Owner.fromJson(json['owner'] as Map<String,dynamic>) : null,
        isCreated = json['isCreated'] as bool?,
        images = (json['images'] as Map<String,dynamic>?) != null ? Images.fromJson(json['images'] as Map<String,dynamic>) : null,
        disponibility = json['disponibility'] as List?,
        creationStep = json['creationStep'] as int?,
        pricePerDay = json['pricePerDay'] as int?,
        pricePerWeek = json['pricePerWeek'] as int?,
        pricePerMonth = json['pricePerMonth'] as int?,
        youngDriver = json['youngDriver'] as bool?,
        city = json['city'] as String?,
        zipCode = json['zipCode'] as String?,
        address = json['address'] as String?,
        description = json['description'] as String?,
        nextTechnicalInspectionImage = json['nextTechnicalInspectionImage'] as String?,
        advice = (json['advice'] as List?)?.map((dynamic e) => Advice.fromJson(e as Map<String,dynamic>)).toList(),
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    'status' : status,
    '_id' : id,
    'brand' : brand,
    'model' : model,
    'type' : type,
    'location' : location?.toJson(),
    'year' : year,
    'mileage' : mileage,
    'licensePlate' : licensePlate,
    'gearbox' : gearbox,
    'fuel' : fuel,
    'nextTechnicalInspection' : nextTechnicalInspection,
    'numberOfPlaces' : numberOfPlaces,
    'numberOfDoors' : numberOfDoors,
    'note' : note,
    'equipment' : equipment,
    'owner' : owner?.toJson(),
    'isCreated' : isCreated,
    'images' : images?.toJson(),
    'disponibility' : disponibility,
    'creationStep' : creationStep,
    'pricePerDay' : pricePerDay,
    'pricePerWeek' : pricePerWeek,
    'pricePerMonth' : pricePerMonth,
    'youngDriver' : youngDriver,
    'city' : city,
    'zipCode' : zipCode,
    'address' : address,
    'description' : description,
    'nextTechnicalInspectionImage' : nextTechnicalInspectionImage,
    'advice' : advice?.map((e) => e.toJson()).toList(),
    '__v' : v
  };
}

class Location {
  final String? lat;
  final String? long;
  final String? id;

  Location({
    this.lat,
    this.long,
    this.id,
  });

  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as String?,
        long = json['long'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'long' : long,
    '_id' : id
  };
}

class Owner {
  final int? money;
  final bool? askingForValidation;
  final List<dynamic>? favouriteCar;
  final Notification? notification;
  final String? id;
  final String? nextEmail;
  final String? registrationDate;
  final String? accountType;
  final String? status;
  final int? forgotValidedCode;
  final String? loginType;
  final String? facebookId;
  final bool? isUserValidated;
  final List<dynamic>? car;
  final String? phone;
  final String? nextPhone;
  final String? phoneValidationCode;
  final int? v;

  Owner({
    this.money,
    this.askingForValidation,
    this.favouriteCar,
    this.notification,
    this.id,
    this.nextEmail,
    this.registrationDate,
    this.accountType,
    this.status,
    this.forgotValidedCode,
    this.loginType,
    this.facebookId,
    this.isUserValidated,
    this.car,
    this.phone,
    this.nextPhone,
    this.phoneValidationCode,
    this.v,
  });

  Owner.fromJson(Map<String, dynamic> json)
      : money = json['money'] as int?,
        askingForValidation = json['askingForValidation'] as bool?,
        favouriteCar = json['favouriteCar'] as List?,
        notification = (json['notification'] as Map<String,dynamic>?) != null ? Notification.fromJson(json['notification'] as Map<String,dynamic>) : null,
        id = json['_id'] as String?,
        nextEmail = json['nextEmail'] as String?,
        registrationDate = json['registrationDate'] as String?,
        accountType = json['accountType'] as String?,
        status = json['status'] as String?,
        forgotValidedCode = json['forgotValidedCode'] as int?,
        loginType = json['loginType'] as String?,
        facebookId = json['facebookId'] as String?,
        isUserValidated = json['isUserValidated'] as bool?,
        car = json['car'] as List?,
        phone = json['phone'] as String?,
        nextPhone = json['nextPhone'] as String?,
        phoneValidationCode = json['phoneValidationCode'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    'money' : money,
    'askingForValidation' : askingForValidation,
    'favouriteCar' : favouriteCar,
    'notification' : notification?.toJson(),
    '_id' : id,
    'nextEmail' : nextEmail,
    'registrationDate' : registrationDate,
    'accountType' : accountType,
    'status' : status,
    'forgotValidedCode' : forgotValidedCode,
    'loginType' : loginType,
    'facebookId' : facebookId,
    'isUserValidated' : isUserValidated,
    'car' : car,
    'phone' : phone,
    'nextPhone' : nextPhone,
    'phoneValidationCode' : phoneValidationCode,
    '__v' : v
  };
}

class Notification {
  final LocationAsk? locationAsk;
  final RentConfirmation? rentConfirmation;
  final Message? message;
  final RentAbort? rentAbort;
  final Contract? contract;
  final Pay? pay;
  final String? id;

  Notification({
    this.locationAsk,
    this.rentConfirmation,
    this.message,
    this.rentAbort,
    this.contract,
    this.pay,
    this.id,
  });

  Notification.fromJson(Map<String, dynamic> json)
      : locationAsk = (json['locationAsk'] as Map<String,dynamic>?) != null ? LocationAsk.fromJson(json['locationAsk'] as Map<String,dynamic>) : null,
        rentConfirmation = (json['rentConfirmation'] as Map<String,dynamic>?) != null ? RentConfirmation.fromJson(json['rentConfirmation'] as Map<String,dynamic>) : null,
        message = (json['message'] as Map<String,dynamic>?) != null ? Message.fromJson(json['message'] as Map<String,dynamic>) : null,
        rentAbort = (json['rentAbort'] as Map<String,dynamic>?) != null ? RentAbort.fromJson(json['rentAbort'] as Map<String,dynamic>) : null,
        contract = (json['contract'] as Map<String,dynamic>?) != null ? Contract.fromJson(json['contract'] as Map<String,dynamic>) : null,
        pay = (json['pay'] as Map<String,dynamic>?) != null ? Pay.fromJson(json['pay'] as Map<String,dynamic>) : null,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'locationAsk' : locationAsk?.toJson(),
    'rentConfirmation' : rentConfirmation?.toJson(),
    'message' : message?.toJson(),
    'rentAbort' : rentAbort?.toJson(),
    'contract' : contract?.toJson(),
    'pay' : pay?.toJson(),
    '_id' : id
  };
}

class LocationAsk {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  LocationAsk({
    this.app,
    this.sMS,
    this.mail,
  });

  LocationAsk.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class RentConfirmation {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  RentConfirmation({
    this.app,
    this.sMS,
    this.mail,
  });

  RentConfirmation.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Message {
  final bool? app;
  final bool? mail;

  Message({
    this.app,
    this.mail,
  });

  Message.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'mail' : mail
  };
}

class RentAbort {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  RentAbort({
    this.app,
    this.sMS,
    this.mail,
  });

  RentAbort.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Contract {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  Contract({
    this.app,
    this.sMS,
    this.mail,
  });

  Contract.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Pay {
  final bool? app;
  final bool? mail;

  Pay({
    this.app,
    this.mail,
  });

  Pay.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'mail' : mail
  };
}

class Images {
  final String? avant34;
  final String? lateral;
  final String? ariere34;
  final String? interieur;
  final String? supplementaire;
  final String? id;

  Images({
    this.avant34,
    this.lateral,
    this.ariere34,
    this.interieur,
    this.supplementaire,
    this.id,
  });

  Images.fromJson(Map<String, dynamic> json)
      : avant34 = json['avant34'] as String?,
        lateral = json['lateral'] as String?,
        ariere34 = json['ariere34'] as String?,
        interieur = json['interieur'] as String?,
        supplementaire = json['supplementaire'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'avant34' : avant34,
    'lateral' : lateral,
    'ariere34' : ariere34,
    'interieur' : interieur,
    'supplementaire' : supplementaire,
    '_id' : id
  };
}

class Advice {
  final String? id;
  final String? user;
  final int? note;
  final String? comment;
  final String? car;
  final int? v;

  Advice({
    this.id,
    this.user,
    this.note,
    this.comment,
    this.car,
    this.v,
  });

  Advice.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        user = json['user'] as String?,
        note = json['note'] as int?,
        comment = json['comment'] as String?,
        car = json['car'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'user' : user,
    'note' : note,
    'comment' : comment,
    'car' : car,
    '__v' : v
  };
}