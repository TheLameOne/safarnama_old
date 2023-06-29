import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utils/styles.dart';

class Bookings extends StatefulWidget {
  String? status;
  String? packagename;
  String? bookingid;
  DateTime? bookedon;

  Bookings(
      {required this.status,
      required this.bookedon,
      required this.bookingid,
      required this.packagename});
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final TextEditingController _reviewController = TextEditingController();
  var status = '';
  var feedback = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    status = widget.status!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            widget.packagename!,
            style: TextStyle(color: Colors.black),
          ),
          actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Congratulations
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Congratulations!",
                              //   style: TextStyle(
                              //       fontSize: 22, fontWeight: FontWeight.bold),
                              // ),
                              // Text(
                              //   "Your tickets are successfully booked.",
                              //   style: TextStyle(fontSize: 16),
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "Booking ID: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.bookingid!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "BookedOn: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.bookedon.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Status: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.status!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 32,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Package",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Experience Kerala",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Passengers",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "2 Adults, 1 Child",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 32,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Departure",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "18/07/2023 * 11:00 pm",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (status == 'Completed') ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        width: size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Give feedback",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "How was your experience?",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              // Stars
                              RatingBar.builder(
                                  initialRating: 5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  }),
                              SizedBox(height: 12),
                              Text(
                                "Care to share more about it?",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Theme(
                                data: ThemeData.from(
                                  colorScheme: ColorScheme.fromSwatch(
                                      primarySwatch: Colors.amber),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      feedback = value;
                                    });
                                  },
                                  minLines: 1,
                                  maxLines: 4,
                                  cursorColor: Colors.amber,
                                  controller: _reviewController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      hintText: "Write your Feedback here.",
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                              SizedBox(height: 16),
                              InkWell(
                                onTap: () {
                                  print(feedback);
                                },
                                child: Container(
                                  width: size.width * 0.9,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.amber),
                                ),
                              ),
                              SizedBox(height: 8)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16, bottom: 16),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(builder: (context) => SplashPage()),
              //           (Route<dynamic> route) => false);
              //     },
              //     child: Container(
              //       height: 50,
              //       width: 200,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           gradient: LinearGradient(
              //             colors: [Styles.primaryColor, HexColor('9AE8FD')],
              //             begin: Alignment.bottomRight,
              //             end: Alignment.topRight,
              //           )),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 10),
              //         child: Center(
              //           child: (isLoading == false)
              //               ? Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text('Back To Home',
              //                         style: TextStyle(
              //                             fontSize: 16,
              //                             color: Colors.white,
              //                             fontWeight: FontWeight.w600)),
              //                   ],
              //                 )
              //               : const SizedBox(
              //                   height: 20.0,
              //                   width: 20,
              //                   child:
              //                       CircularProgressIndicator(color: Colors.blue),
              //                 ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
            // Booking Detals
          ),
        ),
      ),
    );
  }
}
