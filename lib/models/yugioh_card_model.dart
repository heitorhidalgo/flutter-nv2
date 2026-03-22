class YugiohCardModel {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final String description;

  YugiohCardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.description,
  });

  factory YugiohCardModel.fromJson(Map<String, dynamic> json) {
    return YugiohCardModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['card_images'][0]['image_url'],
      description: json['desc'],
    );
  }
}
