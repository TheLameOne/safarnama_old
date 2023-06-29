import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/global.dart';
import '../../utils/styles.dart';
import '../booking/bookings.dart';

class BookingScreen extends StatefulWidget {
  static const String routeNamed = "BookingScreen";

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final fireStore = FirebaseFirestore.instance
      .collection("Booked Packages")
      .where("Bookedby", isEqualTo: userId)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            // leading: InkWell(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: Icon(
            //     Icons.arrow_back,
            //     color: Colors.black,
            //   ),
            // ),
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "My Trips",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              Icon(
                Icons.refresh_rounded,
                color: Styles.primaryColor,
                size: 32,
              ),
              SizedBox(width: 8)
            ],
            bottom: TabBar(
              indicatorColor: Styles.primaryColor,
              tabs: [
                Tab(
                    child: Text(
                  "All",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )),
                Tab(
                    child: Text(
                  "Completed",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: [
                        // All
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upcoming(${snapshot.data!.size})",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i < snapshot.data!.size;
                                              i++)
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Bookings(
                                                        status: snapshot
                                                            .data
                                                            ?.docs[i][
                                                                "Bookingstatus"]
                                                            .toString(),
                                                        bookingid: '1',
                                                        packagename: snapshot
                                                            .data
                                                            ?.docs[i]
                                                                ["packagename"]
                                                            .toString(),
                                                        bookedon: snapshot
                                                            .data
                                                            ?.docs[i]
                                                                ["bookingid"]
                                                            .toDate(),
                                                      ),
                                                    ));
                                              },
                                              child: Card(
                                                elevation: 2,
                                                shadowColor: Colors.grey[100],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey[50],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                width: 60,
                                                                height: 60,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[i]["packagetitleimg"]
                                                                              .toString(),
                                                                        ),
                                                                        fit: BoxFit.cover),
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    color: Colors.blue)),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Upcoming | Fri 03 Feb",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          14,
                                                                    )),
                                                                Text(
                                                                  snapshot
                                                                      .data!
                                                                      .docs[i][
                                                                          "packagename"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 16,
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            4),
                                                                    Text(
                                                                        '2 Adults, 1 Child',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black54,
                                                                          fontSize:
                                                                              14,
                                                                        )),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Others(1)",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Bookings(
                                                  status: "Completed",
                                                  bookedon: DateTime.now(),
                                                  bookingid: "1",
                                                  packagename: "Kasol Trip",
                                                ),
                                              ));
                                        },
                                        child: Card(
                                          elevation: 2,
                                          shadowColor: Colors.grey[100],
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey[50],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://images.pexels.com/photos/11060852/pexels-photo-11060852.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                                                  fit: BoxFit
                                                                      .cover),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  Colors.blue)),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Completed | Fri 03 Feb",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                              )),
                                                          Text(
                                                            "Experience Kerala",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                size: 16,
                                                              ),
                                                              SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                  '2 Adults, 1 Child',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        14,
                                                                  )),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // Completed
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Others(1)",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Bookings(
                                                status: "Completed",
                                                bookedon: DateTime.now(),
                                                bookingid: "2",
                                                packagename: "Andaman Trip"),
                                          ));
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shadowColor: Colors.grey[100],
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[50],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://images.pexels.com/photos/11060852/pexels-photo-11060852.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                                              fit:
                                                                  BoxFit.cover),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.blue)),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Completed | Fri 03 Feb",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          )),
                                                      Text(
                                                        "Experience Kerala",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 16,
                                                          ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                              '2 Adults, 1 Child',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
              })),
    );
  }
}
