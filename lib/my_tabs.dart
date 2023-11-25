import 'package:flutter/material.dart';
import 'appcolors.dart' as AppColors;

class AppTabs extends StatelessWidget {
  final Color colors ;
  final String st  ;

  const AppTabs({Key ? key, required this.colors, required this.st}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 100,
        height: 50,
        child: Text(
          this.st, style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: this.colors,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                offset: Offset(0,0),
              )
            ]
        )
    );
  }
}
