import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  String? categories;
  Color? color;

  CategoriesCard({required this.categories, required this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {},
      child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          width: 100,
          alignment: Alignment.center,
          child: Text(categories!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold))),
    );
  }
}
