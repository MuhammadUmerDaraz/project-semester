import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:umer_wallpaper/color.dart';
import 'package:umer_wallpaper/model/wallpaper_model.dart';



class SetWallpaperScreen extends StatefulWidget {
  final Wallpaper wallpaper;

  const SetWallpaperScreen({super.key, required this.wallpaper});

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {



  Future<void> setWallpaperHome(url) async {
      await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';  
  }

    Future<void> setWallpaperLock(url) async {
      await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';  
  }

  
    Future<void> setWallpaperBoth(url) async {
      await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Set Wallpaper',style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: textColor,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Stack(
       
          children: [
            // Full-Screen Image
            CachedNetworkImage(
              imageUrl: widget.wallpaper.fullImageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
           Container(
            width: double.infinity,
            height: 600,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 20),

              customButton(
                text:'Set Home Screen', 
                onPressed:  () =>setWallpaperHome(widget.wallpaper.fullImageUrl)
                ),

               const SizedBox(height: 10),

              customButton(
                  text:'Set Lock Screen', 
                onPressed:  () =>setWallpaperLock(widget.wallpaper.fullImageUrl)
                ),

               const SizedBox(height: 10),

              customButton(
                  text:'Set Both Screen', 
                onPressed:  () =>setWallpaperBoth(widget.wallpaper.fullImageUrl)
                ),

          
              ],
            ),
           )
          ],
        ),
      ),
    );
  }




 Widget customButton(
  {
    required String text,
    required Function() onPressed,
  }
 ){
  return  ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor
              ),
              onPressed: onPressed,
              child: Text(text,style: TextStyle(color: textColor),),
            );
 }
}
