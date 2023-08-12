class CategoryModel {
  final String? id;
  final String? title;
  final String? subTitle;
  final String? image;
  final String? minPrice;
  final String? createdAt;
  final String? updatedAt;

  CategoryModel({
    this.id,
    this.title,
    this.subTitle,
    this.image,
    this.minPrice,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        title = json['title'] as String?,
        subTitle = json['subTitle'] as String?,
        image = json['image'] as String?,
        minPrice = json['minPrice'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'title' : title,
    'subTitle' : subTitle,
    'image' : image,
    'minPrice' : minPrice,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}