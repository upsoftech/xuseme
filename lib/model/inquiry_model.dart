
class InquiryModel {
  final Enquiry? enquiry;
  final CustomerInfo? customerInfo;
  final PartnerInfo? partnerInfo;

  InquiryModel({
    this.enquiry,
    this.customerInfo,
    this.partnerInfo,
  });

  InquiryModel.fromJson(Map<String, dynamic> json)
      : enquiry = (json['enquiry'] as Map<String, dynamic>?) != null
            ? Enquiry.fromJson(json['enquiry'] as Map<String, dynamic>)
            : null,
        customerInfo = (json['customerInfo'] as Map<String, dynamic>?) != null
            ? CustomerInfo.fromJson(
                json['customerInfo'] as Map<String, dynamic>)
            : null,
        partnerInfo = (json['partnerInfo'] as Map<String, dynamic>?) != null
            ? PartnerInfo.fromJson(json['partnerInfo'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'enquiry': enquiry?.toJson(),
        'customerInfo': customerInfo?.toJson(),
        'partnerInfo': partnerInfo?.toJson()
      };
}

class Enquiry {
  final String? id;
  final String? customerId;
  final String? partnerId;
  final String? createdAt;
  final String? updatedAt;

  Enquiry({
    this.id,
    this.customerId,
    this.partnerId,
    this.createdAt,
    this.updatedAt,
  });

  Enquiry.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        customerId = json['customerId'] as String?,
        partnerId = json['partnerId'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'customerId': customerId,
        'partnerId': partnerId,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}

class CustomerInfo {
  final String? id;
  final String? mobile;
  final String? createdAt;
  final String? updatedAt;
  final String? type;
  final String? email;
  final String? name;
  final String? profileLogo;

  CustomerInfo({
    this.id,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.email,
    this.name,
    this.profileLogo,
  });

  CustomerInfo.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        mobile = json['mobile'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        type = json['type'] as String?,
        email = json['email'] as String?,
        name = json['name'] as String?,
        profileLogo = json['profileLogo'] as String?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'mobile': mobile,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'type': type,
        'email': email,
        'name': name,
        'profileLogo': profileLogo
      };
}

class PartnerInfo {
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

  PartnerInfo({
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

  PartnerInfo.fromJson(Map<String, dynamic> json)
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
        '_id': id,
        'name': name,
        'mobile': mobile,
        'landline': landline,
        'email': email,
        'type': type,
        'shopName': shopName,
        'shopType': shopType,
        'address': address,
        'landmark': landmark,
        'pincode': pincode,
        'state': state,
        'services': services,
        'shopLogo': shopLogo,
        'profileLogo': profileLogo,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
