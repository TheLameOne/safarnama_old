import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../custom/BallanceField.dart';
import '../../custom/CategoriesCard.dart';
import '../../custom/CustomSearchButton.dart';
import '../../custom/CustomSearchField.dart';
import '../../custom/PackageCard.dart';
import '../../custom/PlanCard.dart';
import '../../models/package_model.dart';
import '../../utils/database_service.dart';
import '../../utils/global.dart';
import '../../utils/json.dart';
import '../../utils/styles.dart';
import 'package:flutter/services.dart' as rootbundle;

import '../package_overview_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeNamed = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollViewController = ScrollController();
  final fireStore =
      FirebaseFirestore.instance.collection("Packages").snapshots();
  // final fav = FirebaseFirestore.instance
  //     .collection("Users")
  //     .where("phonenumber", isEqualTo: userId)
  //     .snapshots();

  bool visible = false;
  bool search = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController.addListener(() {
      setState(() {
        visible = _scrollViewController.offset > 300 ? true : false;
        search = _scrollViewController.offset > 570 ? true : false;
        // print(_scrollViewController.offset);
        // print(visible);
      });
    });
  }

  List<String> categories = [
    "Relaxing",
    "Trekking",
    "Camping",
    "Honeymoon",
  ];

  List<Color> colors = [
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.amber,
    Colors.pinkAccent
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DatabaseService());
    final size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(),
        body: CustomScrollView(controller: _scrollViewController, slivers: [
          SliverAppBar(
            backgroundColor: (!visible) ? Colors.white : Styles.primaryColor,
            // centerTitle: ,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/6465964/pexels-photo-6465964.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    fit: BoxFit.cover,
                  ),
                  // borderRadius:
                  //     BorderRadius.only(bottomRight: Radius.circular(50)
                  //     )
                ),
                height: size.height * 0.4,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Title
                        Text(
                          heroHeading,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Hero Search Bar
                        Row(
                          children: [
                            // Search bar
                            CustomSearchField(
                                width: size.width * 0.5,
                                labelText: '',
                                hintText: 'Where you want to go?',
                                initialValue: '',
                                onChanged: (val) {}),
                            // Search Button
                            CustomSearchButton(
                              labelText: 'Search',
                              onTap: () {},
                              containerColor: Colors.yellow,
                            )
                          ],
                        )
                      ]),
                ),
              ),
            ),
            pinned: true,
            stretch: true,
            // snap: true,
            // floating: true,
// 4 mins
            expandedHeight: size.height * 0.4,
            elevation: 0,
            actions: [
              // search Icon
              Visibility(visible: visible, child: Icon(Icons.search)),
              SizedBox(
                width: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Styles.textFieldColor),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onTap: (() {}),
                      child: BallanceField(),
                    )),
              ),
              SizedBox(width: 12),
              InkWell(
                  onTap: () {},
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.share)),
              SizedBox(width: 24),
              InkWell(
                onTap: () {},
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.notifications),
              ),
              SizedBox(width: 12)
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Packages
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Exciting Packages',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      StreamBuilder<QuerySnapshot>(
                          stream: fireStore,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                height: 200,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    for (int i = 0;
                                        i < snapshot.data!.size;
                                        i++)
                                      InkWell(
                                        onTap: () {
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PackageOverviewScreen(
                                                  description: snapshot.data
                                                      ?.docs[i]["description"]
                                                      .toString(),
                                                  duration: snapshot
                                                      .data?.docs[i]["duration"]
                                                      .toString(),
                                                  favourite: false,
                                                  heading: snapshot
                                                      .data
                                                      ?.docs[i]
                                                          ["headingOfPackage"]
                                                      .toString(),
                                                  location: snapshot
                                                      .data?.docs[i]["location"]
                                                      .toString(),
                                                  price: snapshot
                                                      .data?.docs[i]["price"]
                                                      .toDouble(),
                                                  rating: snapshot
                                                      .data?.docs[i]["rating"]
                                                      .toDouble(),
                                                  trip: snapshot.data
                                                      ?.docs[i]["packageName"]
                                                      .toString(),
                                                  packageid: snapshot.data
                                                      ?.docs[i]["packageId"]
                                                      .toString(),
                                                  packagename: snapshot.data
                                                      ?.docs[i]["packageName"]
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: PackageCard(
                                            // trip: packages[i].packagename,
                                            trip: snapshot
                                                .data?.docs[i]["packageName"]
                                                .toString(),
                                            duration: snapshot
                                                .data?.docs[i]["duration"]
                                                .toString(),
                                            location: snapshot
                                                .data?.docs[i]["location"]
                                                .toString(),
                                            heading: snapshot.data
                                                ?.docs[i]["headingOfPackage"]
                                                .toString(),
                                            description: snapshot
                                                .data?.docs[i]["packageName"]
                                                .toString(),
                                            rating: snapshot
                                                .data?.docs[i]["rating"]
                                                .toDouble(),
                                            price: snapshot
                                                .data?.docs[i]["price"]
                                                .toDouble(),
                                            favourite: false),
                                      )
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              print("error 2");
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else {
                              print("Error 3");
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Travel Categories',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              add: 50.0,
              // widget: Text("Harsh")
              widget: Column(
                children: [
                  // Visibility(
                  //   visible: search,
                  //   child: Container(
                  //     color: Colors.white,
                  //     child: Row(
                  //       children: [
                  //         // Search bar
                  //         CustomSearchField(
                  //             width: size.width * 0.72,
                  //             height: 50,
                  //             labelText: '',
                  //             border: true,
                  //             textColor: Colors.grey,
                  //             hintText: 'Where you want to go?',
                  //             initialValue: '',
                  //             onChanged: (val) {}),
                  //         // Search Button
                  //         CustomSearchButton(
                  //           height: 50,
                  //           labelText: 'Search',
                  //           onTap: () {},
                  //           containerColor: Colors.yellow,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Visibility(
                  //   visible: search,
                  //   child: Container(
                  //       color: Colors.white,
                  //       height: 36,
                  //       width: 390,
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 4),
                  //         child: CupertinoSearchTextField(
                  //           onChanged: (String value) {
                  //             print(
                  //                 'The text has changed to: $value');
                  //           },
                  //           onSubmitted: (String value) {
                  //             print('Submitted text: $value');
                  //           },
                  //         ),
                  //       )),
                  // ),
                  Container(
                      color: Colors.white,
                      height: 64,
                      child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < categories.length; i++)
                              CategoriesCard(
                                  categories: categories[i], color: colors[i])
                          ])),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: size.width - 32,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  for (var j = 0; j < 10; j++)
                    Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: PlanCard(
                          days: 2,
                          night: 1,
                          title: 'Experience Kerela',
                          description: 'A journey into the nature',
                          price: 20000,
                          discount: 20,
                          rating: 4,
                        ))
                ]),
              ),
            ),
          )
        ]));
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  double add = 0;

  // (visible == true)? add = 32: add = 0;

  PersistentHeader({required this.widget, required this.add});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: widget,
    );
  }

  @override
  double get maxExtent => 64.0 + add;

  @override
  double get minExtent => 64.0 + add;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
