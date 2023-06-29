import 'package:cloud_firestore/cloud_firestore.dart';

class Packages {
  String? packageavailability;
  String? packagecategory;
  String? packagedescription;
  String? packagediscountpercentage;
  String? packageid;
  String? packageitenary;
  String? packagename;
  String? packageotherimg1;
  String? packageotherimg2;
  String? packageotherimg3;
  String? packageotherimg4;
  String? packageotherimg5;
  String? packageotherimg6;
  String? packagetitleimg;
  String? packagetraveltime;
  String? packageheading;
  String? packageprice;

  Packages({
    this.packageavailability,
    this.packagecategory,
    this.packagedescription,
    this.packagediscountpercentage,
    this.packageid,
    this.packageitenary,
    this.packagename,
    this.packageotherimg1,
    this.packageotherimg2,
    this.packageotherimg3,
    this.packageotherimg4,
    this.packageotherimg5,
    this.packageotherimg6,
    this.packagetitleimg,
    this.packagetraveltime,
    this.packageprice,
    this.packageheading,
  });
  toJson() {
    return {""};
  }

  factory Packages.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Packages(
      packageavailability: data["packageavailability"],
      packagecategory: data["packagecategory"],
      packagedescription: data["packagedescription"],
      packagediscountpercentage: data["packagediscountpercentage"],
      packageid: data["packageid"],
      packageitenary: data["packageitenary"],
      packagename: data["packagename"],
      packageotherimg1: data["packageotherimg1"],
      packageotherimg2: data["packageotherimg2"],
      packageotherimg3: data["packageotherimg3"],
      packageotherimg4: data["packageotherimg4"],
      packageotherimg5: data["packageotherimg5"],
      packageotherimg6: data["packageotherimg6"],
      packageprice: data["packageprice"],
      packagetitleimg: data["packagetitleimg"],
      packagetraveltime: data["packagetraveltime"],
      packageheading: data["packageheading"],
    );
  }
}
