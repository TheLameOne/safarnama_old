import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/packages_model.dart';

class DatabaseService extends GetxController {
  static DatabaseService get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<Packages>> allPackages() async {
    final snapshot = await _db.collection("Packages").get();
    final packages =
        snapshot.docs.map((e) => Packages.fromSnapshot(e)).toList();
    return packages;
  }
}
