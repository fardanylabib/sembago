import 'package:flutter/material.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import "package:sembago/src/widgets/extentions.dart";


class AppBarTop extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leftIcon;
  final Function onLeftIconClick;
  final bool noLeftIcon;
  final bool noUser;
  const AppBarTop({
    Key key,
    this.title,
    this.leftIcon,
    this.onLeftIconClick,
    this.noLeftIcon = false,
    this.noUser = false,
  }) : super(key: key);
  
  Widget _leftIcon(BuildContext buildContext){
    if(this.noLeftIcon){
      return SizedBox.shrink();
    }
    return RotatedBox(
      quarterTurns: 4,
      child: ButtonIcon(
        icon: this.leftIcon == null ? Icons.arrow_back : this.leftIcon,
        color: Colors.black54,
        onClick:(){
          if(this.onLeftIconClick == null){
            Navigator.pop(buildContext);
          }else{
            this.onLeftIconClick(buildContext);
          }
        }
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 25, bottom: 5, right: 10),
      color: Colors.white.withOpacity(0.5),
      child: Row(
        children: <Widget>[
          _leftIcon(context),
          Expanded(
            child:Container(
              alignment: Alignment.centerLeft,
              padding: AppTheme.hPadding,
              child: Text(this.title, style: AppTheme.h3Style),
            )
          ),
          this.noUser ? SizedBox.shrink():
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset("assets/user.png", width: 36),
          ).ripple(() {}, borderRadius: BorderRadius.circular(18))
        ],
      ),
    );
  }
}