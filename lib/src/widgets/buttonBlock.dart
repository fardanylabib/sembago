import 'package:flutter/material.dart';
import 'package:sembago/src/themes/light_color.dart';

class ButtonBlock extends StatelessWidget {
  final String text;
  final Function onClick;
  final int type;
  static const int TYPE_WHITE = 2;
  static const int TYPE_BORDER = 1;
  static const int TYPE_DEFAULT = 0;

  const ButtonBlock({
    Key key,
    this.text,
    this.onClick,
    this.type = TYPE_DEFAULT
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: 
          this.type == TYPE_BORDER ?
          BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white, width: 2),
          ):
          this.type == TYPE_WHITE ?
          BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white
          ):
          BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]
              )
          ),
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 20, 
            color: this.type == TYPE_WHITE ? LightColor.orange : Colors.white
          ),
        ),
      ),
    );
  }
}