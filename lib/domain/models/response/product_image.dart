class ProductImage {
  int? id;
  String urlPath;
  String? description;
  String? label;

  ProductImage({this.id, required this.urlPath, this.description, this.label});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      urlPath: json['url_path'],
      description: json['description'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url_path'] = this.urlPath;
    data['description'] = this.description;
    data['label'] = this.label;
    return data;
  }
}
