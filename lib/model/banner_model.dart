class BannerModel {
  final String? id;
  final String? partnerId;
  final String? bannerImage;
  final String? validity;
  final String? price;
  final String? transactionId;
  final String? createdAt;
  final String? updatedAt;

  BannerModel({
    this.id,
    this.partnerId,
    this.bannerImage,
    this.validity,
    this.price,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
  });

  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        partnerId = json['partnerId'] as String?,
        bannerImage = json['bannerImage'] as String?,
        validity = json['validity'] as String?,
        price = json['price'] as String?,
        transactionId = json['transactionId'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'partnerId' : partnerId,
    'bannerImage' : bannerImage,
    'validity' : validity,
    'price' : price,
    'transactionId' : transactionId,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}