class YugiohCardModel {
  final int id;
  final String name;
  final String type;
  final String imageUrl;

  YugiohCardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  factory YugiohCardModel.fromJson(Map<String, dynamic> json) {
    return YugiohCardModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['card_images'][0]['image_url_cropped'],
    );
  }
}
