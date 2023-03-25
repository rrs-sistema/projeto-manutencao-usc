import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color textColor;
  const ProfileTile(
      {Key? key, this.title, this.subtitle, this.textColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title!,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle!,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        ),
      ],
    );
  }
}
