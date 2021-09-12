import 'package:flutter/material.dart';
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/widgets/extentions.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  final Color color;
  const ButtonIcon({Key key, this.icon, this.onClick, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Icon(icon, color: this.color == null ? LightColor.iconColor : this.color),
      ).ripple(onClick, borderRadius: BorderRadius.circular(20));
  }
}