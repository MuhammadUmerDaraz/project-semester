class Wallpaper {
  final String id;
  final String previewUrl;
  final String fullImageUrl;
  final String category;

  Wallpaper({
    required this.id,
    required this.previewUrl,
    required this.fullImageUrl,
    required this.category,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'].toString(),
      previewUrl: json['previewURL'],
      fullImageUrl: json['webformatURL'],
      category: json['category'] ?? 'Uncategorized',
    );
  }
}
