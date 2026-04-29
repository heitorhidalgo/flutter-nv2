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
    final cardImages = json['card_images'];
    final imageUrl = (cardImages != null && cardImages.isNotEmpty)
        ? (cardImages[0]['image_url'] ?? '')
        : '';

    return YugiohCardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      imageUrl: imageUrl,
      description: json['desc'] ?? '',
    );
  }
}