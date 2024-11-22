import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:umer_wallpaper/Screens/set_wallaper.dart';
import 'package:umer_wallpaper/color.dart';
import 'package:umer_wallpaper/logic/api_service.dart';
import 'package:umer_wallpaper/model/wallpaper_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Wallpaper> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

_loadFavorites() async {
  // Retrieve the saved favorites from shared preferences
  final prefs = await SharedPreferences.getInstance();
  final favoriteIds = prefs.getStringList('favorites') ?? [];




  final service = WallpaperService();
  List<Wallpaper> wallpapers = [];
 
     // Within _loadFavorites function
  for (var id in favoriteIds) {
  var wallpaper = await service.fetchWallpaperById(id);
  if (wallpaper != null) {
    wallpapers.add(wallpaper);
      
    } 
  }
  setState(() {
    _favorites = wallpapers;
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Favorites",style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),),
        elevation: 0,
        centerTitle: true,
         leading: IconButton(
          icon: Icon(Icons.arrow_back,color: textColor,),
          onPressed: () => Navigator.pop(context),
        ),
        ),
      body: _favorites.isEmpty
          ? const Center(child: Text("No favorites yet."))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _favorites.length,
              itemBuilder: (BuildContext context, int index) {
                var wallpaper = _favorites[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to full-screen image
                     Navigator.push(context, MaterialPageRoute(builder: ((context) => SetWallpaperScreen(wallpaper: wallpaper))));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: wallpaper.fullImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
