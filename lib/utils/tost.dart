
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/utils/colors.dart';

void tost(String Data)
{
  Fluttertoast.showToast(msg: Data.toString(),backgroundColor: white,textColor: Color(0xff03174C));
}