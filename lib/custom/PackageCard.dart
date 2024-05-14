import 'package:flutter/material.dart';
import '../utils/styles.dart';

class PackageCard extends StatefulWidget {
  String? trip;
  String? duration;
  String? location;
  String? heading;
  String? description;
  double? rating;
  double? price;
  bool? favourite;
  String? dp;

  PackageCard(
      {this.trip,
      this.duration,
      this.heading,
      this.description,
      this.rating,
      this.price,
      this.favourite,
      this.location,
      this.dp});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.dp!), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue),
        width: 150,
        alignment: Alignment.center,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Styles.textFieldColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 6),
                      child: Text(widget.rating!.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                  Icon(
                    Icons.share,
                    size: 22,
                    color: Colors.white,
                  )
                ],
              ),
              // bottom
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trip Name
                  Text(widget.trip!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nights and day
                      Text(widget.duration!,
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      // Heart Icon
                      InkWell(
                        onTap: () {
                          (widget.favourite!)
                              ? setState(() {
                                  widget.favourite = false;
                                })
                              : setState(() {
                                  widget.favourite = true;
                                });
                        },
                        child: (widget.favourite!)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                      )
                    ],
                  ),
                  // Star Rating
                  Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        (i < widget.rating!.toInt())
                            ? Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              )
                            : Icon(
                                Icons.star_outline,
                                color: Colors.amber,
                                size: 20,
                              ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
            // Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
            ));
  }
}
