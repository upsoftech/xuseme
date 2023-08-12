class ShopSubCategoryModel {
  final String? id;
  final String? name;
  final String? mobile;
  final String? landline;
  final String? email;
  final String? type;
  final String? shopName;
  final String? shopType;
  final String? address;
  final String? landmark;
  final String? pincode;
  final String? state;
  final String? services;
  final String? shopLogo;
  final String? profileLogo;
  final String? createdAt;
  final String? updatedAt;

  ShopSubCategoryModel({
    this.id,
    this.name,
    this.mobile,
    this.landline,
    this.email,
    this.type,
    this.shopName,
    this.shopType,
    this.address,
    this.landmark,
    this.pincode,
    this.state,
    this.services,
    this.shopLogo,
    this.profileLogo,
    this.createdAt,
    this.updatedAt,
  });

  ShopSubCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        mobile = json['mobile'] as String?,
        landline = json['landline'] as String?,
        email = json['email'] as String?,
        type = json['type'] as String?,
        shopName = json['shopName'] as String?,
        shopType = json['shopType'] as String?,
        address = json['address'] as String?,
        landmark = json['landmark'] as String?,
        pincode = json['pincode'] as String?,
        state = json['state'] as String?,
        services = json['services'] as String?,
        shopLogo = json['shopLogo'] as String?,
        profileLogo = json['profileLogo'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name' : name,
    'mobile' : mobile,
    'landline' : landline,
    'email' : email,
    'type' : type,
    'shopName' : shopName,
    'shopType' : shopType,
    'address' : address,
    'landmark' : landmark,
    'pincode' : pincode,
    'state' : state,
    'services' : services,
    'shopLogo' : shopLogo,
    'profileLogo' : profileLogo,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}