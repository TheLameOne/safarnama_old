import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../../custom/CheckoutTextField.dart';
import '../../custom/persons.dart';
import '../../utils/global.dart';
import '../../utils/styles.dart';
import 'booking_confirmed.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeNamed = "CheckoutScreen";
  double price;
  String? packagename;
  String? packageid;
  CheckoutScreen(
      {required this.price,
      required this.packageid,
      required this.packagename});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController dateinput = TextEditingController();
  final textController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final referalController = TextEditingController();
  int persons = 1;
  double baseFare = 0;
  double taxes = 0;
  double total = 0;
  var referalCode = '';

  final firstName = List<String>.empty(growable: true);
  final lastName = List<String>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    baseFare = widget.price;
    taxes = baseFare * 0.18;
    total = baseFare + taxes;
    dateinput.text = "";
  }

  void _couplePackage() {
    (couplePackage) ? baseFare = baseFare + 1000 : baseFare = baseFare - 1000;
  }

  void _walletBalance() {
    (walletBalance)
        ? baseFare = baseFare - balance
        : baseFare = baseFare + balance;
  }

  void _createBooking() {
    FirebaseFirestore.instance.collection('Booked Packages').add({
      'Bookedby': userId,
      'Bookingstatus': 'upcoming',
      'Isreferralapplied': false,
      'Remaingfsbalance': 100,
      'Rerralcode': referalCode,
      'Totalrefferalbalanceapplied': 100,
      'bookedon': DateFormat('yMd').format(DateTime.now()),
      'bookingid': DateTime.now(),
      'packagediscountpercentage': 20,
      'packageid': widget.packageid,
      'packageitenary': '',
      'packageprice': widget.price,
      'packagetitleimg':
          'https://images.pexels.com/photos/11060852/pexels-photo-11060852.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'packagetraveltime': '5 Nights/4 Days',
      'totalprice': 20000,
      'packagename': widget.packagename,
      'coupleinclusionpackage': couplePackage,
      'gstnumber': gstValue,
      'dateoftravel': 'today',
    });
  }

  List<String> couplePackageData = ["Candle Light Dinner", "Room Decoration"];

  DateTime selectedDate = DateTime.now();

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: context, //context of current state
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(
  //           2000), //DateTime.now() - not to allow to choose before today.
  //       lastDate: DateTime(2101));

  //   if (pickedDate != null) {
  //     print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     print(
  //         formattedDate); //formatted date output using intl package =>  2021-03-16
  //   } else {
  //     print("Date is not selected");
  //   }
  // }

  // List<Gender> fList = [
  //   Gender(
  //     index: 1,
  //     name: "Mr.",
  //   ),
  //   Gender(
  //     index: 2,
  //     name: "Ms.",
  //   ),
  //   Gender(
  //     index: 3,
  //     name: "Mrs.",
  //   ),
  // ];
  // String radioItem = 'Mr.';
  // int id = 1;

  bool gstValue = false;
  bool couplePackage = false;
  bool walletBalance = false;
  bool showReferal = false;

  @override
  Widget build(BuildContext context) {
    var name = '';
    var email = '';
    var phoneNumber = '';
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            // backgroundColor: Colors.blue,
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
                  "Traveller Details",
                  style: TextStyle(color: Colors.black),
                ),
                actions: []),
            body: SingleChildScrollView(
              child: Container(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name, email, Phone number
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          children: [
                            // Name
                            CheckoutTextField(
                              width: size.width * 0.9,
                              labelText: 'Name',
                              hintText: 'Name',
                              onChanged: (val) {
                                name = val!;
                              },
                              controller: textController,
                            ),
                            SizedBox(height: 8),
                            // Email
                            CheckoutTextField(
                                width: size.width * 0.9,
                                labelText: 'E-mail',
                                hintText: 'E-mail',
                                controller: emailController,
                                onChanged: (val) {
                                  email = val!;
                                }),
                            SizedBox(height: 8),
                            // Phone Number
                            CheckoutTextField(
                                width: size.width * 0.9,
                                labelText: 'Phone Number',
                                hintText: 'Phone Number',
                                controller: phoneController,
                                textInputType: TextInputType.number,
                                onChanged: (val) {
                                  phoneNumber = val!;
                                }),
                            SizedBox(height: 8),

                            Container(
                              width: size.width * 0.9,
                              child: TextField(
                                controller:
                                    dateinput, //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(Icons
                                        .calendar_today), //icon of text field
                                    labelText:
                                        "Date of Travel" //label text of field
                                    ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            )
                            // Center(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: <Widget>[
                            //       Text("${selectedDate.toLocal()}"
                            //           .split(' ')[0]),
                            //       const SizedBox(
                            //         height: 20.0,
                            //       ),
                            //       ElevatedButton(
                            //         onPressed: () => _selectDate(context),
                            //         child: const Text('Select date'),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // Adult list view
                      Container(
                        width: size.width * 0.9,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Persons(
                              persons: persons,
                            );
                          },
                          itemCount: persons,
                        ),
                      ),
                      // Add and remove button
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        child: Container(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox.shrink(),
                              Row(
                                children: [
                                  Visibility(
                                    visible: (persons > 1) ? true : false,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          persons = persons - 1;
                                          temp = temp - 1;
                                          firstName.removeLast();
                                        });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.red),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        persons = persons + 1;
                                        // temp = temp + 1;
                                        firstName.add('');
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.green),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // GST Number
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: size.width * 0.9,
                          child: Column(
                            children: [
                              // Use GST number for this booking
                              Row(children: [
                                // Checkbox
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: gstValue,
                                  onChanged: (value) {
                                    setState(() {
                                      gstValue = value!;
                                    });
                                  },
                                ),
                                Text("Use GST number for this booking")
                              ]),
                              Visibility(
                                visible: gstValue,
                                child: Column(
                                  children: [
                                    //  GST number
                                    CheckoutTextField(
                                        width: size.width * 0.9,
                                        labelText: 'GST Number',
                                        hintText: 'GST Number',
                                        onChanged: (val) {}),
                                    SizedBox(height: 8),
                                    // Company Name
                                    CheckoutTextField(
                                        width: size.width * 0.9,
                                        labelText: 'Company Name',
                                        hintText: 'Company Name',
                                        onChanged: (val) {}),
                                    SizedBox(height: 8),
                                    // Address
                                    CheckoutTextField(
                                        width: size.width * 0.9,
                                        labelText: 'Address',
                                        hintText: 'Address',
                                        onChanged: (val) {}),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Couple
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          width: size.width * 0.9,
                          child: Row(children: [
                            // Checkbox
                            Checkbox(
                              activeColor: Colors.amber,
                              value: couplePackage,
                              onChanged: (value) {
                                setState(() {
                                  couplePackage = value!;
                                });
                                _couplePackage();
                              },
                            ),
                            Text("Do you want couple inclusion package"),
                            SizedBox(width: 4),
                            InkWell(
                              child: Icon(Icons.info),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (int i = 0;
                                                  i < couplePackageData.length;
                                                  i++)
                                                Text(
                                                    "${i + 1}. ${couplePackageData[i]}"),
                                            ],
                                          ),
                                        ),
                                        titleTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      );
                                    });
                              },
                            )
                          ]),
                        ),
                      ),
                      // By proceeding, you accept our T&Cs.
                      Container(
                        width: size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              // Checkbox
                              Checkbox(
                                activeColor: Colors.amber,
                                value: walletBalance,
                                onChanged: (value) {
                                  setState(() {
                                    walletBalance = value!;
                                    _walletBalance();
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Apply Wallet Ballance"),
                                  Text("Balance : $balance"),
                                ],
                              )
                            ]),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Visibility(
                                visible: !showReferal,
                                child: Container(
                                    width: size.width * 0.9,
                                    child: Center(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showReferal = true;
                                        });
                                      },
                                      child: Text(
                                        "Have referral code ?",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 16),
                                      ),
                                    ))),
                              ),
                              Visibility(
                                visible: showReferal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.4,
                                      height: size.height * 0.05,
                                      child: TextFormField(
                                          minLines: 1,
                                          maxLines: 1,
                                          controller: referalController,
                                          decoration: InputDecoration(
                                              hintText: "Referral Code",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                          onChanged: (value) {
                                            setState(() {
                                              referalCode = value;
                                            });
                                          }),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        successToast(
                                            'Applied Successfully', context);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.check),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            showReferal = false;
                                            referalController.clear();
                                          });
                                        },
                                        child: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            size: 32,
                                          ),
                                        )))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black12),
                        height: 40,
                        width: size.width * 0.9,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("By proceeding, you accept our "),
                            Text(
                              "T&Cs.",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        )),
                      ),
                      // Fare Summary
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Container(
                          width: size.width * 0.9,
                          child: Column(
                            children: [
                              // Fare Summary
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fare Summary",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Details",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              // Base Fare
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Base Fare",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54)),
                                  Text('\u{20B9}${baseFare * persons}',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87))
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Taxes & Fees",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54)),
                                  Text('\u{20B9}${taxes * persons}',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87))
                                ],
                              ),
                              SizedBox(height: 8),
                              // Taxes & Fees
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(color: Colors.black12),
                                        bottom:
                                            BorderSide(color: Colors.black12))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // Total Amount
                                  children: [
                                    Text("Total Amount",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold)),
                                    Text('\u{20B9}${total * persons}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: Colors.black38)),
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("\u{20B9}${total * persons}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "View Details",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.amber,
                      ),
                      child: InkWell(
                        onTap: () {
                          _createBooking();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmed(),
                              ));
                        },
                        child: Center(
                            child: Text(
                          "Proceed to Pay",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Gender {
//   String? name;
//   int? index;
//   Gender({this.name, this.index});
// }
