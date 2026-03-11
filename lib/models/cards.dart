class Cards {
  final int id;
  final String name;
  final String type;
  final String imageUrl;

  Cards({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['card_images'][0]['image_url_cropped'],
    );
  }
}
