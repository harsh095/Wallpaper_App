
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:wallpaper_app/screens/view_img.dart';
import 'package:wallpaper_app/utils/strings.dart';
import 'package:wallpaper_app/utils/textstyle.dart';

import '../utils/colors.dart';
class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {
  List images = [];
  int page = 1;
  String key="wallpaper";
  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    // Dispose of the scroll controller to avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }

  // Listener function to check scroll position and load more if at the end
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the end of the scroll view
      loadmore();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchapi();
    _scrollController.addListener(_scrollListener);
  }

  fetchapi() async {
    images.clear();
    page=1;
    await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$key?per_page=80'),
        headers: {'Authorization': 'To4hKHAAuytjoNxsy8na0A7OqPfQ9ff02MxRryOUJiX6KlXvYkp4NCQS'}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  void search(String data)
  {
   if(data=="")
     {
       key="wallpaper";
     }
   else
     {
       key=data;
     }
    fetchapi();
  }
  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/search?query=$key?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {'Authorization': 'To4hKHAAuytjoNxsy8na0A7OqPfQ9ff02MxRryOUJiX6KlXvYkp4NCQS'}).then(
            (value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['photos']);
          });
        });
  }
int i=0;

  Widget build(BuildContext context) {
  final me=  MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          i++;
        });debugPrint("object");
        if (i == 2) {
          SystemNavigator.pop();
          return true;
        }
        // Exit the app

        return false; // Allow the pop operation
      },
      child: Scaffold(
        backgroundColor: Color(0xff03174C),
        body: Stack(
          children: [
            Image.asset(
              "assets/img_1.png", // replace with your image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SizedBox(
                width: me.width,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: me.height * .05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Wall",style: TextStyle(color: font_color,fontSize: 28,fontFamily: "Popiins",fontWeight: FontWeight.w600)),
                          GradientText(
                            'app',
                            style: TextStyle(fontSize: 28,fontFamily: "Popiins",fontWeight: FontWeight.w600),
                            colors: [
                              Color(0xffFFA200),
                              Color(0xffFFDD00)

                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: me.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(data_string,textAlign: TextAlign.center,style: TextStyle(color: font_color,fontSize: 16,fontFamily: "ABeeZee")),
                      ),
                      SizedBox(
                        height: me.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            style: TextStyle(color: font_color,fontSize: 14,fontFamily: "ABeeZee"),
                            onChanged: (value) {
                              search(value.toString());
                            },
                            cursorColor: font_color,
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.search_sharp,color: font_color,),
                              hintText: serch_string,
                              hintStyle: TextStyle(color: font_color,fontSize: 14,fontFamily: "ABeeZee"),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: white,
                                    width: .05
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                  white,
                                    width: .05
                                ),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                  white,
                                    width: .05
                                ),

                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                  white,
                                    width: .05
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                     Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: GridView.builder(
                               shrinkWrap: true,
                                primary: false,
                                itemCount: images.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    crossAxisCount: 3,
                                    childAspectRatio: 2 / 4,
                                    mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return TouchRippleEffect(
                                    rippleColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewImage(
                                                link: images[index]['src']['large2x'],
                                              )));
                                    },
                                    child: SizedBox(
                                      height: me.height,
                                      width: me.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          images[index]['src']['tiny'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                   ),




                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

