import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../custom/PackageCard.dart';
import '../../models/package_model.dart';
import '../../utils/json.dart';
import '../package_overview_screen.dart';
import '../packages.dart';

class FavouriteScreen extends StatefulWidget {
  static const String routeNamed = "FavouriteScreen";

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Favourites",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<PackageModel>;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Budget Travel',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PackagesScreen.routeNamed);
                                  },
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
                          Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0; i < items.length; i++)
                                  InkWell(
                                    onTap: () {
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PackageOverviewScreen(
                                              description: items[i].description,
                                              duration: items[i].duration,
                                              favourite: items[i].favourite,
                                              heading: items[i].heading,
                                              location: items[i].location,
                                              price: items[i].price,
                                              rating: items[i].rating,
                                              trip: items[i].trip,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: PackageCard(
                                      trip: items[i].trip,
                                      duration: items[i].duration,
                                      location: items[i].location,
                                      heading: items[i].heading,
                                      description: items[i].description,
                                      rating: items[i].rating,
                                      price: items[i].price,
                                      favourite: items[0].favourite,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Group Travel',
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
                          Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0; i < items.length; i++)
                                  InkWell(
                                    onTap: () {
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PackageOverviewScreen(
                                              description: items[i].description,
                                              duration: items[i].duration,
                                              favourite: items[i].favourite,
                                              heading: items[i].heading,
                                              location: items[i].location,
                                              price: items[i].price,
                                              rating: items[i].rating,
                                              trip: items[i].trip,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: PackageCard(
                                      trip: items[i].trip,
                                      duration: items[i].duration,
                                      location: items[i].location,
                                      heading: items[i].heading,
                                      description: items[i].description,
                                      rating: items[i].rating,
                                      price: items[i].price,
                                      favourite: items[0].favourite,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Adventure',
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
                          Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0; i < items.length; i++)
                                  InkWell(
                                    onTap: () {
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PackageOverviewScreen(
                                              description: items[i].description,
                                              duration: items[i].duration,
                                              favourite: items[i].favourite,
                                              heading: items[i].heading,
                                              location: items[i].location,
                                              price: items[i].price,
                                              rating: items[i].rating,
                                              trip: items[i].trip,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: PackageCard(
                                      trip: items[i].trip,
                                      duration: items[i].duration,
                                      location: items[i].location,
                                      heading: items[i].heading,
                                      description: items[i].description,
                                      rating: items[i].rating,
                                      price: items[i].price,
                                      favourite: items[0].favourite,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Solo Travel',
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
                          Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0; i < items.length; i++)
                                  InkWell(
                                    onTap: () {
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PackageOverviewScreen(
                                              description: items[i].description,
                                              duration: items[i].duration,
                                              favourite: items[i].favourite,
                                              heading: items[i].heading,
                                              location: items[i].location,
                                              price: items[i].price,
                                              rating: items[i].rating,
                                              trip: items[i].trip,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: PackageCard(
                                      trip: items[i].trip,
                                      duration: items[i].duration,
                                      location: items[i].location,
                                      heading: items[i].heading,
                                      description: items[i].description,
                                      rating: items[i].rating,
                                      price: items[i].price,
                                      favourite: items[0].favourite,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else
              return const Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}
