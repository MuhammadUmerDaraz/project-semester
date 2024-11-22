import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:umer_wallpaper/model/wallpaper_model.dart';

class WallpaperService {
  final String apiKey = '26406727-184422f1995b27ca750ec0b04';  // Add your API key



  // Fetch wallpapers by query and color (previously added)
  Future<List<Wallpaper>> fetchWallpapers(String query, String color) async {
    final colorQuery = color.isNotEmpty ? '&colors=$color' : '';
    final url =
        'https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&per_page=200$colorQuery';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List)
          .map((json) => Wallpaper.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }



  // Fetch wallpapers by category
  Future<List<Wallpaper>> fetchCategoryWallpapers(String category) async {
    final url =
        'https://pixabay.com/api/?key=$apiKey&q=$category&image_type=photo&per_page=200';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List)
          .map((json) => Wallpaper.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load category wallpapers');
    }
  }



Future<Wallpaper?> fetchWallpaperById(String id) async {
  final url = Uri.parse('https://pixabay.com/api/?key=$apiKey&id=$id'); // Correct URL for Pixabay
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['hits'] != null && data['hits'].isNotEmpty) {
      // Assuming the first hit is the desired wallpaper
      return Wallpaper.fromJson(data['hits'][0]);  // Parse the first wallpaper object
    } else {
      print('No wallpapers found for ID $id');
      return null;
    }
  } else {
    print('Failed to load wallpaper with ID $id: ${response.statusCode}');
    return null;
  }
}


}
