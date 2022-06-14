import 'package:capston_project/common/const.dart';
import 'package:flutter/material.dart';

class CradMenuItem extends StatelessWidget {
  const CradMenuItem({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 118,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGreen1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          iconData,
          color: kwhite,
          size: 50,
        ),
      ),
    );
  }
}
