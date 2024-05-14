import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safarnama/custom/PlanCard.dart';
import 'package:safarnama/screens/package_overview_screen.dart';

class SearchPage extends StatefulWidget {
  String text;

  SearchPage({required this.text});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: StreamBuilder<QuerySnapshot>(
              stream: (widget.text != "")
                  ? FirebaseFirestore.instance
                      .collection("Packages")
                      .where("maps", isNotEqualTo: widget.text)
                      .orderBy("maps")
                      .startAt([
                      widget.text,
                    ]).endAt([
                      '${widget.text}\uf8ff',
                    ]).snapshots()
                  : FirebaseFirestore.instance
                      .collection("Packages")
                      .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        for (var i = 0; i < snapshot.data!.size; i++)
                          Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: InkWell(
                                onTap: () {
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PackageOverviewScreen(
                                          description: snapshot
                                              .data?.docs[i]["description"]
                                              .toString(),
                                          duration: snapshot
                                              .data?.docs[i]["duration"]
                                              .toString(),
                                          fav: snapshot.data?.docs[i]["fav"],
                                          heading: snapshot
                                              .data?.docs[i]["headingOfPackage"]
                                              .toString(),
                                          location: snapshot
                                              .data?.docs[i]["location"]
                                              .toString(),
                                          price: snapshot.data?.docs[i]["price"]
                                              .toDouble(),
                                          rating: snapshot
                                              .data?.docs[i]["rating"]
                                              .toDouble(),
                                          trip: snapshot
                                              .data?.docs[i]["packageName"]
                                              .toString(),
                                          packageid: snapshot
                                              .data?.docs[i]["packageId"]
                                              .toString(),
                                          packagename: snapshot
                                              .data?.docs[i]["packageName"]
                                              .toString(),
                                          gallery: snapshot
                                              .data?.docs[i]["gallery"]
                                              .toString(),
                                          image: snapshot.data?.docs[i]["image"]
                                              .toString(),
                                          maps: snapshot.data?.docs[i]["maps"]
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: PlanCard(
                                  duration: snapshot.data?.docs[i]["duration"]
                                      .toString(),
                                  heading: snapshot.data?.docs[i]["packageName"]
                                      .toString(),
                                  description: snapshot
                                      .data?.docs[i]["headingOfPackage"]
                                      .toString(),
                                  price: snapshot.data?.docs[i]["price"]
                                      .toDouble(),
                                  discount: snapshot.data?.docs[i]["discount"]
                                      .toDouble(),
                                  rating: snapshot.data?.docs[i]["rating"]
                                      .toDouble(),
                                  image: snapshot.data?.docs[i]["image"]
                                      .toString(),
                                ),
                              ))
                      ]),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print("error 2");
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  print("Error 3");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
