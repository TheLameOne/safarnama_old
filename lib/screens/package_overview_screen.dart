import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../custom/PackageCard.dart';
import '../utils/styles.dart';
import 'booking/checkout_screen.dart';

class PackageOverviewScreen extends StatefulWidget {
  static const String routeNamed = "PackageOverviewScreen";
  String? trip;
  String? duration;
  String? location;
  String? heading;
  String? description;
  double? rating;
  double? price;
  bool fav;
  String? packagename;
  String? packageid;
  String? maps;
  String? image;
  String? gallery;

  PackageOverviewScreen(
      {this.trip,
      this.duration,
      this.heading,
      this.description,
      this.rating,
      this.price,
      required this.fav,
      this.location,
      this.packageid,
      this.packagename,
      this.maps,
      this.image,
      this.gallery});

  @override
  State<PackageOverviewScreen> createState() => _PackageOverviewScreenState();
}

class _PackageOverviewScreenState extends State<PackageOverviewScreen>
    with SingleTickerProviderStateMixin {
  final fireStore =
      FirebaseFirestore.instance.collection("Packages").snapshots();
  final ScrollController _scrollViewController = ScrollController();

  bool scrolled = false;
  late Future<List<String>> links;
  TabController? tabController;

  @override
  void initState() {
    links = getAllImageUrls(widget.gallery!);
    tabController = TabController(length: 2, vsync: this);
    _scrollViewController.addListener(() {
      setState(() {
        scrolled = _scrollViewController.offset > 300 ? true : false;
        // print(_scrollViewController.offset);
        // print(visible);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(controller: _scrollViewController, slivers: [
          SliverAppBar(
            backgroundColor: (!scrolled) ? Colors.white : Styles.primaryColor,
            title: Text(widget.trip!),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
            // centerTitle: ,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                    image: NetworkImage(widget.image!),
                    fit: BoxFit.cover,
                  ),
                  // borderRadius:
                  //     BorderRadius.only(bottomRight: Radius.circular(50)
                  //     )
                ),
                height: size.height * 0.4,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: null,
                      width: null,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.trip!,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // openMap(26.9124, 75.7873);
                                        openMapLoc(widget.maps!);
                                        print(widget.maps!);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            widget.location!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      (widget.fav)
                                          ? Icon(
                                              Icons.favorite_rounded,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Row(
                                      children: [
                                        for (var i = 0; i < 5; i++)
                                          (i < widget.rating!.toInt())
                                              ? Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                )
                                              : Icon(
                                                  Icons.star_outline,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      "(2124 Reviews)",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
            stretch: true,
            expandedHeight: size.height * 0.4,
            elevation: 0,
            // backgroundColor: Styles.primaryColor,
            actions: [
              // search Icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              )
              // Visibility(visible: visible, child: Icon(Icons.search)),
            ],
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: tabController,
                indicatorColor: Colors.amber,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Overview"),
                  Tab(text: "Gallery"),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(controller: tabController, children: [
              Stack(children: [
                ListView(
                  children: [
                    Container(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: FutureBuilder(
                                      future: links,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: Center(
                                                child: SizedBox(
                                                  height: 64,
                                                  width: 64,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return ImageScreen(
                                                  link: snapshot.data![i],
                                                );
                                              }));
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data![i]),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: Colors.blue),
                                            ));
                                      }))
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Row(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           for (var i = 0; i < 5; i++)
                    //             (i < widget.rating!.toInt())
                    //                 ? Icon(
                    //                     Icons.star,
                    //                     color: Colors.amber,
                    //                     size: 20,
                    //                   )
                    //                 : Icon(
                    //                     Icons.star_outline,
                    //                     color: Colors.amber,
                    //                     size: 20,
                    //                   ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         width: 16,
                    //       ),
                    //       Text("${widget.rating} out of 5(2124 Reviews)")
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            Text(
                              widget.heading!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Text(widget.description!)
                            // Content
                          ]),
                    ),
                    Column(
                      children: [
                        // Packages
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Other Exciting Packages',
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
                                                          description: snapshot
                                                              .data
                                                              ?.docs[i][
                                                                  "description"]
                                                              .toString(),
                                                          duration: snapshot
                                                              .data
                                                              ?.docs[i]
                                                                  ["duration"]
                                                              .toString(),
                                                          fav: snapshot.data
                                                              ?.docs[i]["fav"],
                                                          heading: snapshot
                                                              .data
                                                              ?.docs[i][
                                                                  "headingOfPackage"]
                                                              .toString(),
                                                          location: snapshot
                                                              .data
                                                              ?.docs[i]
                                                                  ["location"]
                                                              .toString(),
                                                          price: snapshot.data
                                                              ?.docs[i]["price"]
                                                              .toDouble(),
                                                          rating: snapshot
                                                              .data
                                                              ?.docs[i]
                                                                  ["rating"]
                                                              .toDouble(),
                                                          trip: snapshot
                                                              .data
                                                              ?.docs[i][
                                                                  "packageName"]
                                                              .toString(),
                                                          packageid: snapshot
                                                              .data
                                                              ?.docs[i]
                                                                  ["packageId"]
                                                              .toString(),
                                                          packagename: snapshot
                                                              .data
                                                              ?.docs[i][
                                                                  "packageName"]
                                                              .toString(),
                                                          gallery: snapshot
                                                              .data
                                                              ?.docs[i][
                                                                  "packageName"]
                                                              .toString(),
                                                          image: snapshot.data
                                                              ?.docs[i]["image"]
                                                              .toString(),
                                                          maps: snapshot.data
                                                              ?.docs[i]["image"]
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: PackageCard(
                                                    // trip: packages[i].packagename,
                                                    dp: snapshot.data?.docs[i]["image"]
                                                        .toString(),
                                                    trip: snapshot.data
                                                        ?.docs[i]["packageName"]
                                                        .toString(),
                                                    duration: snapshot.data
                                                        ?.docs[i]["duration"]
                                                        .toString(),
                                                    location: snapshot.data
                                                        ?.docs[i]["location"]
                                                        .toString(),
                                                    heading: snapshot
                                                        .data
                                                        ?.docs[i]
                                                            ["headingOfPackage"]
                                                        .toString(),
                                                    description: snapshot.data
                                                        ?.docs[i]["packageName"]
                                                        .toString(),
                                                    rating: snapshot.data?.docs[i]["rating"]
                                                        .toDouble(),
                                                    price: snapshot.data?.docs[i]["price"].toDouble(),
                                                    favourite: false),
                                              )
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      print("error 2");
                                      return Center(
                                          child:
                                              Text(snapshot.error.toString()));
                                    } else {
                                      print("Error 3");
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                              price: widget.price!,
                              packagename: widget.packagename,
                              packageid: widget.packageid),
                        ),
                      );
                    },
                    child: Container(
                        height: size.height * 0.09,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.amber,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rs ${widget.price?.toInt().toString()}/-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.duration!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              Text(
                                "Book Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ]),
              FutureBuilder(
                future: links,
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 128,
                        width: 128,
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Container(
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 3,
                        children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return ImageScreen(
                                      link: snapshot.data![i],
                                    );
                                  }));
                                },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(snapshot.data![i]),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                }),
              )
            ]),
          )
        ]),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class ImageScreen extends StatelessWidget {
  String? link;
  ImageScreen({this.link});
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        child: Container(
          // height: size.height / 2,
          // width: size.width,
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: Image.network(
                link!,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Future<List<String>> getAllImageUrls(String loc) async {
  final ref = FirebaseStorage.instance.ref().child("/$loc");
  final result = await ref.listAll();
  final urls = <String>[];
  for (var item in result.items) {
    final url = await item.getDownloadURL();
    print(url);
    urls.add(url);
  }
  print(urls);
  return urls;
}

Future<void> openMap(double latitude, double longitude,
    {LaunchMode linkLaunchMode = LaunchMode.externalApplication}) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl), mode: linkLaunchMode);
  } else {
    throw 'Could not open the map.';
  }
}

Future<void> openMapLoc(String locationName,
    {LaunchMode linkLaunchMode = LaunchMode.externalApplication}) async {
  String googleUrl =
      // 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      'https://www.google.com/maps/search/?api=1&query=$locationName';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl), mode: linkLaunchMode);
  } else {
    throw 'Could not open the map.';
  }
}
