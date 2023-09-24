class ShopSubCategoryModel {
  final String? id;
  final String? mobile;
  final String? type;
  final bool? isPremium;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? address;
  final String? email;
  final String? landline;
  final String? landmark;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? pincode;
  final String? profileLogo;
  final String? services;
  final String? shopLogo;
  final String? shopName;
  final String? shopType;
  final String? state;
  final List<dynamic>? offers;
  final List<dynamic>? premiumOffers;

  ShopSubCategoryModel({
    this.id,
    this.mobile,
    this.type,
    this.isPremium,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.address,
    this.email,
    this.landline,
    this.landmark,
    this.latitude,
    this.longitude,
    this.name,
    this.pincode,
    this.profileLogo,
    this.services,
    this.shopLogo,
    this.shopName,
    this.shopType,
    this.state,
    this.offers,
    this.premiumOffers,
  });

  ShopSubCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        mobile = json['mobile'] as String?,
        type = json['type'] as String?,
        isPremium = json['isPremium'] as bool?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        address = json['address'] as String?,
        email = json['email'] as String?,
        landline = json['landline'] as String?,
        landmark = json['landmark'] as String?,
        latitude = json['latitude'] as double?,
        longitude = json['longitude'] as double?,
        name = json['name'] as String?,
        pincode = json['pincode'] as String?,
        profileLogo = json['profileLogo'] as String?,
        services = json['services'] as String?,
        shopLogo = json['shopLogo'] as String?,
        shopName = json['shopName'] as String?,
        shopType = json['shopType'] as String?,
        state = json['state'] as String?,
        offers = json['offers'] as List?,
        premiumOffers = json['premiumOffers'] as List?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'mobile' : mobile,
    'type' : type,
    'isPremium' : isPremium,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'address' : address,
    'email' : email,
    'landline' : landline,
    'landmark' : landmark,
    'latitude' : latitude,
    'longitude' : longitude,
    'name' : name,
    'pincode' : pincode,
    'profileLogo' : profileLogo,
    'services' : services,
    'shopLogo' : shopLogo,
    'shopName' : shopName,
    'shopType' : shopType,
    'state' : state,
    'offers' : offers,
    'premiumOffers' : premiumOffers
  };
}