import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:umer_wallpaper/color.dart';


  String searchWithColor = '';

  final List<Color> colorsList = [
    Colors.red, Colors.green, Colors.blue, Colors.yellow,
    Colors.orange, Colors.purple, Colors.brown, Colors.pink,
  ];




void showAlertDialog(BuildContext context,{
  required String title,
  required String buttonText,
  required Function() onPressed,
  required TextEditingController searchController,

}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(56, 56, 56, 0.485),
        title: Text(title,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        content: SizedBox(
          width: 250,
          height: 150,
          child:  Column(
          children: [
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white,fontSize: 14,),
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for wallpapers...',
                hintStyle: const TextStyle(color: Colors.white54,fontSize: 13,fontWeight: FontWeight.bold),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white)
                ),
                 focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: textColor)
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 250,
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorsList.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    if(colorsList[index] == Colors.red){
                      searchWithColor = 'red';
                    }else if(colorsList[index] == Colors.green){
                      searchWithColor = 'green';
                    }else if(colorsList[index] == Colors.blue){
                      searchWithColor = 'blue';
                    }else if(colorsList[index] == Colors.yellow){
                      searchWithColor = 'yellow';
                    }else if(colorsList[index] == Colors.orange){
                      searchWithColor = 'orange';
                    }else if(colorsList[index] == Colors.purple){
                      searchWithColor = 'purple';
                    }else if(colorsList[index] == Colors.brown){
                      searchWithColor = 'brown';
                    }else if(colorsList[index] == Colors.pink){
                      searchWithColor = 'pink';
                    }
                    else{
                      searchWithColor = '';
                    }
                  },
                  child: Container(
                  margin: const EdgeInsets.all(5),
                  width: 35,
                  height: 55,
                  decoration: BoxDecoration(
                    color: colorsList[index],
                  ),
                ),
                );
              },
              
            ),
          )
          ],
        ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Cancel",style: TextStyle(color: Colors.white,),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText,style: const TextStyle(color: Colors.white,),)
          ),
        ],
      ).blurry(
  blur: 5,
  width: 200,
  height: 200,
  elevation: 0,
  color: Colors.transparent,
  padding: const EdgeInsets.all(8),
  borderRadius: const BorderRadius.all(Radius.circular(20)),
);
    },
  );
}


 





