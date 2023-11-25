import 'package:flutter/material.dart';
import 'appcolors.dart' as AppColors;
import 'bookmodel.dart';

class TodosScreen extends StatelessWidget {
  int bookId =0;
  List<dynamic> data ;
  // matensa tfawite hayde el bi myHomepage
   TodosScreen({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(data[1]),
      ),
      resizeToAvoidBottomInset: false,
      //passing in the ListView.builder

      body: SingleChildScrollView(
        child:Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 120,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10),
                    image: DecorationImage(
                     scale: 1,
                     image: AssetImage(
                          data[3]),
                    ),
                  )
              ),
              const SizedBox(width: 20),
             Expanded(child:
             Column(
                 crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      SizedBox(height:12),
                    //Text(data[1], style: const TextStyle(fontSize: 18,fontFamily: "Avenir", fontWeight: FontWeight.bold)),
                   Text(data[4], style: const TextStyle(fontSize: 14, fontFamily: "italic")),
                      Text(data[5], style: const TextStyle(fontSize: 14, fontFamily: "italic")),
                   SizedBox(height: 180,),
                   Text(data[2], style: const TextStyle(fontSize: 12, fontFamily: "Avenir" ))

        ]
                    ),
             )
               ]
             ),


          ),
      )
    );


  }
}


