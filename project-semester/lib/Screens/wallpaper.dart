import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umer_wallpaper/Screens/favorites.dart';
import 'package:umer_wallpaper/Screens/set_wallaper.dart';
import 'package:umer_wallpaper/color.dart';
import 'package:umer_wallpaper/logic/api_service.dart';
import 'package:umer_wallpaper/model/wallpaper_model.dart';
import 'package:umer_wallpaper/widgets/alert_box.dart';




class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final WallpaperService _service = WallpaperService();
  final TextEditingController _searchController = TextEditingController();
  List<Wallpaper> _wallpapers = [];
  Set<String> _favorites = <String>{};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
     _searchWallpapers('car');
  }

  _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  _toggleFavorite(Wallpaper wallpaper) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(wallpaper.id)) {
        _favorites.remove(wallpaper.id);
      } else {
        _favorites.add(wallpaper.id);
      }
      prefs.setStringList('favorites', _favorites.toList());
    });
  }

  _searchWallpapers(String query) async {
    if (query.isEmpty) return;
    final wallpapers = await _service.fetchWallpapers(query,searchWithColor);
    setState(() {
      _wallpapers = wallpapers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Umer Wallpaper',style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: textColor,),
            onPressed: () {
              showAlertDialog
              (context, 
              title: 'Search', 
              buttonText: 'Search', 
              searchController: _searchController,
              onPressed: (){
              _searchWallpapers(_searchController.text);
              Navigator.of(context).pop();
              });
       
            }),
        ],
      ),
      body: Column(
        children: [
       
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 2.0,
                mainAxisExtent: 300
              ),
              itemCount: _wallpapers.length,
              itemBuilder: (context, index) {
                final wallpaper = _wallpapers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => SetWallpaperScreen(wallpaper: wallpaper))));
                  },
                  child: Stack(
                     children: [

                   Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(image: CachedNetworkImageProvider(wallpaper.fullImageUrl),fit: BoxFit.cover)
                    ),
                   ),
                   
                 
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            _favorites.contains(wallpaper.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () => _toggleFavorite(wallpaper),
                        ),
                      ),

                   ],
                  ),

                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.favorite,color: textColor,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: ((context) => const FavoritesScreen())));
        }),
    );
  }
}
