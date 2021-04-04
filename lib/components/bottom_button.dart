import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CONST_COR_CINZA,
              width: 1.0,
            ),
          )
      ),
      child: FlatButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            // fontSize: getProportionateScreenWidth(14),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
