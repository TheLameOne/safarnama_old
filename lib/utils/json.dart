import 'dart:convert';
import '../models/package_model.dart';
import 'package:flutter/services.dart' as rootbundle;

Future<List<PackageModel>> readJsonData() async {
  final jsondata = await rootbundle.rootBundle.loadString('json/package.json');
  // print(jsondata);
  final list = json.decode(jsondata) as List<dynamic>;
  List<PackageModel> res = [];
  for (var item in list) {
    res.add(PackageModel.fromJson(item));
  }
  return res;
  // return list.map((e) => DataModel.fromJson(e)).toList();
}
