class BrandItem {
  int? id;
  String? name;
  String? price;
  String? description;
  int? imageId;
  int? userId;
  int? brandId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Upload? upload;

  BrandItem(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.imageId,
      this.userId,
      this.brandId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.upload});

  BrandItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageId = json['imageId'];
    userId = json['UserId'];
    brandId = json['BrandId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    upload =
        json['Upload'] != null ? new Upload.fromJson(json['Upload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['imageId'] = this.imageId;
    data['UserId'] = this.userId;
    data['BrandId'] = this.brandId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.upload != null) {
      data['Upload'] = this.upload!.toJson();
    }
    return data;
  }
}

class Upload {
  int? id;
  String? path;
  String? filename;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Upload(
      {this.id,
      this.path,
      this.filename,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Upload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    filename = json['filename'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['filename'] = this.filename;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
