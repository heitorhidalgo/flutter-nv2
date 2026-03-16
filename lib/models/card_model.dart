class CardModel {
  final int id;
  final String name;
  final String type;
  final String imageUrl;

  CardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['card_images'][0]['image_url_cropped'],
    );
  }
}
