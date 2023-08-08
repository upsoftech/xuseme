class AddressModel {
  final String? id;
  final String? userId;
  final String? address;
  final String? landmark;
  final String? pincode;
  final String? state;
  final String? createdAt;
  final String? updatedAt;

  AddressModel({
    this.id,
    this.userId,
    this.address,
    this.landmark,
    this.pincode,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        userId = json['userId'] as String?,
        address = json['address'] as String?,
        landmark = json['landmark'] as String?,
        pincode = json['pincode'] as String?,
        state = json['state'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'userId' : userId,
    'address' : address,
    'landmark' : landmark,
    'pincode' : pincode,
    'state' : state,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}