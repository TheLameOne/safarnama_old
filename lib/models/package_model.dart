class PackageModel {
  String? trip;
  String? duration;
  String? location;
  String? heading;
  String? description;
  double? rating;
  double? price;
  bool? favourite;
  String? maps;
  String? image;

  PackageModel(
      {this.trip,
      this.duration,
      this.heading,
      this.description,
      this.rating,
      this.price,
      this.favourite,
      this.location,
      this.maps,
      this.image});

  PackageModel.fromJson(Map<String, dynamic> json) {
    trip = json['trip'];
    duration = json['duration'];
    location = json['location'];
    heading = json['heading'];
    description = json['description'];
    rating = json['rating'];
    price = json['price'];
    favourite = json['favourite'];
    maps = json['maps'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['trip'] = trip;
    data['duration'] = duration;
    data['location'] = location;
    data['heading'] = heading;
    data['description'] = description;
    data['rating'] = rating;
    data['price'] = price;
    data['favourite'] = favourite;
    data['maps'] = maps;
    data['image'] = image;
    return data;
  }
}
