class Car {
  int? id;
  String? logo;
  String? img;
  String? name;
  String? model;
  int? rentd;
  List<String>? imgs;
  double? location1;
  double? location2;
  String? location;
  String? type;
  int? seats;
  int? doors;
  String? fuel;
  List<String>? features;
  String? color;
  String? interiorColor;
  String? engine;
  String? drivetrain;
  int? kilometrage;
  String? description;
  String? transmission;
  int? userid;

  //Owner? owner;
  //Review? review;

  Car.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    logo = json["logo"];
    img = json["img"];
    name = json["name"];
    model = json["model"];
    rentd = json["rentd"];
    imgs = json["imgs"].cast<String>();
    location1 = json["location1"];
    location2 = json["location2"];
    location = json["location"];
    type = json["type"];
    seats = json["seats"];
    doors = json["doors"];
    fuel = json["fuel"];
    features = json["features"].cast<String>();
    color = json["color"];
    interiorColor = json["interiorColor"];
    drivetrain = json["drivetrain"];
    engine = json["engine"];
    kilometrage = json["kilometrage"];
    transmission = json["transmission"];
    userid = json["userid"];
    description = json["description"];
  }

  Car({
    required this.id,
    required this.logo,
    required this.img,
    required this.name,
    required this.model,
    required this.rentd,
    required this.imgs,
    required this.location1,
    required this.location2,
    required this.location,
    required this.type,
    required this.seats,
    required this.doors,
    required this.fuel,
    required this.features,
    required this.color,
    required this.interiorColor,
    required this.engine,
    required this.drivetrain,
    required this.kilometrage,
    required this.transmission,
    required this.userid,
    required this.description,
  });
}
