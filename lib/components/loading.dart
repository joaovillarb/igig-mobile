
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igig/constants.dart';

class DialogLoading {
  Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  // backgroundColor: Colors.black45,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        SizedBox(height: 10,),
                        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(CONST_COR_PRIMARIA),),
                        SizedBox(height: 10,),
                        Text("Carregando....",style: TextStyle(color: CONST_COR_PRIMARIA),),
                        SizedBox(height: 10,),
                      ]),
                    )
                  ]));
        });
  }
}