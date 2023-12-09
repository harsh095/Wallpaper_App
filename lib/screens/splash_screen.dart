import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../utils/colors.dart';
import 'home_page.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3),() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeSCreen()),
      );
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff03174C),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img.png", // replace with your image path

              height: 20,
              width: 20,

            ),
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            Text("Unlimited Free Wallpaper",style: TextStyle(color: font_color,fontSize: 18,fontFamily: "Popiins")),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFFA200),
                        Color(0xffFFDD00)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Text("4K HD Phone Wallpapers",style: TextStyle(color: Color(0xff12143A),fontSize: 12,fontFamily: "Popiins",fontWeight: FontWeight.w600)),
                ),

                SizedBox(width: 2,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFFA200),
                        Color(0xffFFDD00)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Text("Latest 2023",style: TextStyle(color: Color(0xff12143A),fontSize: 12,fontFamily: "Popiins",fontWeight: FontWeight.w600)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

