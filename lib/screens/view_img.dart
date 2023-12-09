import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/utils/strings.dart';
import 'package:wallpaper_app/utils/tost.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
class ViewImage extends StatefulWidget {
  const ViewImage({super.key, required this.link});
  final String? link;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  Future<void> home() async {
    try {
      String url = widget.link.toString();
      int location = WallpaperManager
          .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
      if(result)
        {
          Navigator.pop(context);
          tost("Wallpaper Set In Home Screen");

        }
    } on PlatformException {}
  }
  Future<void> lock() async {
    try {
      String url = widget.link.toString();
      int location = WallpaperManager
          .LOCK_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
      if(result)
      {
        Navigator.pop(context);
        tost("Wallpaper Set In Lock Screen");

      }
    } on PlatformException {}
  }
  Future<void> both() async {
    try {
      String url = widget.link.toString();
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
      if(result)
      {
        Navigator.pop(context);
        tost("Wallpaper Set In Both Screen");

      }
    } on PlatformException {}
  }
  Future<void> downloadAndSaveImage() async {
    // Fetch the image from the URL
    final http.Response response = await http.get(Uri.parse(widget.link.toString()));

    // Decode the image
    final Uint8List bytes = response.bodyBytes;
    final ui.Image image = await decodeImageFromList(bytes);

    // Save the image to the gallery
    final result = await ImageGallerySaver.saveImage(
      bytes,
      quality: 100,
      name: 'downloaded_image',
    );

    print(result);

    String data=result.toString().split(",").last;
    print(data.toString());
    if(data.toString().trim()=="isSuccess: true}")
      {
        Navigator.pop(context);
        tost("Photo Saved!");
      }
    else
      {
        Navigator.pop(context);
        tost("Please Try Again!");
      }

  }

  @override
  Widget build(BuildContext context) {
    final me = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/img_1.png", // replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(
                height: me.height * .1,
              ),
              Container(
                height: me.height * .65,
                width: me.width,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.link.toString(),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: me.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xff03174C),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //setWallpaper();
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext contex) {
                            return Container(
                              height: MediaQuery.of(context).size.height * .35,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xff03060D),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                                )
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 3,
                                    width: 80,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                  ),
                                  SizedBox(height: 30,),
                                  Text("What would you like to do?",style:  TextStyle(
                                      fontSize: 20,
                                      color: font_color,
                                      fontFamily: "ABeeZee"),),
                                  SizedBox(height: 30,),
                                  TouchRippleEffect(
                                    rippleColor: Colors.white,

                                    onTap: ()
                                    {
                                      home();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 45),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                         Image.asset("assets/img_2.png",height: 20,width: 20,),
                                          SizedBox(width: 20,),
                                          Text("Set wallpaper".toUpperCase(),style:  TextStyle(
                                              fontSize: 14,
                                              color:font_color,
                                              letterSpacing: 1,
                                              fontFamily: "ABeeZee"),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TouchRippleEffect(
                                    rippleColor: Colors.white,
                                    onTap: ()
                                    {
                                      lock();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 45),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/img_3.png",height: 20,width: 20,),
                                          SizedBox(width: 20,),
                                          Text("Set lock screen".toUpperCase(),style:  TextStyle(
                                              fontSize: 14,
                                              color:font_color,
                                              letterSpacing: 1,
                                              fontFamily: "ABeeZee"),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TouchRippleEffect(
                                    rippleColor: Colors.white,
                                    onTap: ()
                                    {
                                      both();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 45),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/img_4.png",height: 20,width: 20,),
                                          SizedBox(width: 20,),
                                          Text("Set both".toUpperCase(),style:  TextStyle(
                                              fontSize: 14,
                                              color:font_color,
                                              letterSpacing: 1,
                                              fontFamily: "ABeeZee"),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TouchRippleEffect(
                                    rippleColor: Colors.white,
                                    onTap: ()
                                    {
                                      downloadAndSaveImage();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 45),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/img_5.png",height: 20,width: 20,),
                                          SizedBox(width: 20,),
                                          Text("Save to media folder".toUpperCase(),style:  TextStyle(
                                              fontSize: 14,
                                              color:font_color,
                                              letterSpacing: 1,
                                              fontFamily: "ABeeZee"),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 60,
                      width: me.width * .65,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Text(set_string.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff03174C),
                                fontFamily: "ABeeZee")),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
