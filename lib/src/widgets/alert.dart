import 'package:flutter/material.dart';

class Alert{
  static const int STYLE_DANGER = 0;
  static const int STYLE_SUCCESS = 1;
  static const int STYLE_WARNING = 2;

  static void showAlert(context, {message, style}){
    Color bgColor;
    // Color textColor = Color(0xffffffff);
    switch(style){
      case STYLE_SUCCESS:
        bgColor = Color(0xff00cc00);
        break;
      case STYLE_WARNING:
        bgColor = Color(0xff33cccc);
        break;
      case STYLE_DANGER:
      default:
        bgColor = Color(0xffcc0000);
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: bgColor,
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        )
      );
  }
}