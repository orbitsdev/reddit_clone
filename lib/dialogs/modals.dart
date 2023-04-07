



import 'package:flutter/material.dart';

class Modals {

  static void failed(BuildContext context, {String? e = 'failed'}){
    showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('$e'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
  }

}