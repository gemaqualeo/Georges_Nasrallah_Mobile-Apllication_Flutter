import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'appcolors.dart' as AppColors;
import 'my_tabs.dart';
import 'book_detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key ? key }) : super(key:key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List popularBooks = ([]);
  List Books = ([]);
  List sbooks = ([]);
  List chosenBook =([]);
  int bookId = 0;
  late ScrollController _scrollController  ;
  late TabController _tabController ;
   ReadData() async{
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((String s){
     setState(() {
       popularBooks= jsonDecode(s);
     });
    });
    await DefaultAssetBundle.of(context).loadString("json/newBooks.json").then((String s){
      setState(() {
        Books = jsonDecode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/selectedBooks.json").then((String s){
      setState(() {
        sbooks = jsonDecode(s);
      });
    });
  }
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20) ,
                child:
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Icon(Icons.notifications),
                    ],
                  )
                ],
              )
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text("Popular Books", style: TextStyle(fontSize: 30))
                  )
                ],
              ),
                const SizedBox(height: 20,),
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                     Positioned(
                       top :0 ,
                        left:-20,
                        right: 0,
                       child: Container(
                           height:180,
                             child: PageView.builder(
                               padEnds: false,
                              // clipBehavior: Clip.hardEdge,

                               dragStartBehavior: DragStartBehavior.start,
                               controller: PageController(viewportFraction: 0.5),
                               itemCount: (popularBooks == false )? 0:popularBooks.length,
                               itemBuilder: (_,i){
                                 return Container(
                                   height: 250,
                                   width: MediaQuery.of(context).size.width,
                                   margin: const EdgeInsets.only(right: 10),

                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(40),
                                       image:  DecorationImage(
                                         image: AssetImage(popularBooks[i]["imageLink"]),
                                       )
                                   ),
                                 );
                               }),
                         )
                    )
                    ]
                  ),
                ),  //Section 1
                Expanded(child:  NestedScrollView(
                  controller : _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return[
                      SliverAppBar(
                        pinned:true ,
                        backgroundColor: AppColors.backgroundSilver,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.tabVarViewColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius:7 ,
                                    offset: Offset(0,0),
                                  )
                                ]
                              ), tabs: [
                                AppTabs(colors: AppColors.menu1Color, st: "New"),
                              AppTabs(colors: AppColors.menu2Color, st: "Popular"),
                              AppTabs(colors: AppColors.menu3Color, st: "Selection")
                            ],
                            )
                          )
                        )
                      )
                    ];
                  }, body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: Books == false ? 0: Books.length,
                        itemBuilder:(_,i) {
                          List<dynamic> chbooks = [Books[i]['id'], Books[i]['title'], Books[i]['text'], Books[i]['imageLink'], Books[i]['author'], Books[i]['year'] ];
                           return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TodosScreen( data: chbooks ),
                                ),
                              );
                              },
                               child:Card(
                                 child: Container(
                                   margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                                 child: Container(
                                 decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: const Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),

                                    )
                                  ]
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          image: DecorationImage(
                                            scale: 1,
                                            image: AssetImage(
                                                Books[i]["imageLink"]),
                                          ),
                                        )
                                    ),
                                     SizedBox(width: 20),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(Books[i]["title"],
                                            style: const TextStyle(fontSize: 18,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),),
                                          Text(Books[i]["author"],
                                            style: const TextStyle(fontSize: 16,
                                                fontFamily: "Avenir"),),
                                          Text(Books[i]["pages"],
                                            style: const TextStyle(fontSize: 12,
                                                fontFamily: "Avenir"),),
                                        ]
                                    ),

                                  ],

                                ),
                              ),

                            ),
                          ),
                               ),
                          );
                        }
                      ),
                    ListView.builder(
                     itemCount: popularBooks == false ? 0: popularBooks.length,
                        itemBuilder:(_,i) {
                        List<dynamic> chbooks = [popularBooks[i]['id'], popularBooks[i]['title'], popularBooks[i]['text'], popularBooks[i]['imageLink'],popularBooks[i]['author'], popularBooks[i]['year']];

                          return GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TodosScreen(data: chbooks),
                                ),
                              );
                              bookId = popularBooks[i]['id'];
                              print("Helloooooooooooooooooooooooooo");
                              print(bookId);
                            },
                            child: Card(
                            child: Container(
                             margin: const EdgeInsets.only(
                               left: 20, right: 20, top: 10, bottom: 10),
                               child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: AppColors.tabVarViewColor,
                                 boxShadow: [
                                   BoxShadow(
                                     blurRadius: 2,
                                     offset: Offset(0, 0),
                                     color: Colors.grey.withOpacity(0.2),

                                   )
                                 ]
                             ),
                             child: Container(
                               padding: const EdgeInsets.all(8),
                               child: Row(
                                 children: [
                                   Container(
                                       width: 80,
                                       height: 120,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(
                                             10),
                                         image: DecorationImage(
                                           scale: 1,
                                           image: AssetImage(
                                               popularBooks[i]["imageLink"]),
                                         ),
                                       )
                                   ),
                                   SizedBox(width: 20),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                       children:[
                                         Text(popularBooks[i]["title"], style: TextStyle(fontSize:18, fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                         Text(popularBooks[i]["author"], style: TextStyle(fontSize:16, fontFamily: "Avenir"),),
                                         Text(popularBooks[i]["pages"], style: TextStyle(fontSize:12, fontFamily: "Avenir"),),
                                       ]
                                   ),

                                 ],
                               ),
                             ),
                           ),
                         ),
                         ),

                         );
                       }
                    ),
                    ListView.builder(
                        itemCount: sbooks == false ? 0: sbooks.length,
                        itemBuilder:(_,i) {
                          List<dynamic> chbooks = [sbooks[i]['id'], sbooks[i]['title'], sbooks[i]['text'], sbooks[i]['imageLink'], sbooks[i]['author'], sbooks[i]['year']];
                            return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TodosScreen( data: chbooks),
                                ),
                              );

                              },
                                child: Card(
                              child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                 // borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),

                                    )
                                  ]
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          //borderRadius: BorderRadius.circular(
                                              //10),
                                          image: DecorationImage(
                                            scale: 1,
                                            image: AssetImage(
                                                sbooks[i]["imageLink"]),
                                          ),
                                        )
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(sbooks[i]["title"], style: TextStyle(fontSize:18, fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                          Text(sbooks[i]["author"], style: TextStyle(fontSize:16, fontFamily: "Avenir"),),
                                          Text(sbooks[i]["pages"], style: TextStyle(fontSize:12, fontFamily: "Avenir"),),
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                                ),
                          );
                        } ),

            ]),
          ),
        ),
    ])
    ))
    );
  }
  }



