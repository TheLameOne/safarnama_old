import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/global.dart';
import 'CheckoutTextField.dart';

class Persons extends StatefulWidget {
  int persons;
  Persons({this.persons = 1});

  @override
  State<Persons> createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  final personSize = List<int>.empty(growable: true);

  late int t = 1;

  void initState() {
    super.initState();
    _increment();
  }

  void _increment() {
    for (int i = 0; i < 10; i++) {
      setState(() {
        personSize.add(i);
      });
    }
    t = personSize[widget.persons];
  }

  List<Gender> fList = [
    Gender(
      index: 1,
      name: "Mr.",
    ),
    Gender(
      index: 2,
      name: "Ms.",
    ),
    Gender(
      index: 3,
      name: "Mrs.",
    ),
  ];
  bool gstValue = false;
  String radioItem = 'Mr.';
  int id = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adult 1
            Text(
              "Adult $t",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              width: size.width * 0.9,
              child: Row(
                children: fList
                    .map((data) => Expanded(
                          child: RadioListTile(
                            title: Text(
                              "${data.name}",
                              style: TextStyle(fontSize: 12),
                            ),
                            groupValue: id,
                            value: data.index,
                            onChanged: (val) {
                              setState(() {
                                radioItem = data.name!;
                                id = data.index!;
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
            CheckoutTextField(
                width: size.width * 0.9,
                labelText: 'First Name',
                hintText: 'First Name',
                onChanged: (val) {}),
            SizedBox(height: 8),
            // Second Name
            CheckoutTextField(
                width: size.width * 0.9,
                labelText: 'Middle & Last Name',
                hintText: 'Middle & Last Name',
                onChanged: (val) {}),
            SizedBox(height: 8),
            // Add button
          ],
        ),
      ),
    );
  }
}

class Gender {
  String? name;
  int? index;
  Gender({this.name, this.index});
}
