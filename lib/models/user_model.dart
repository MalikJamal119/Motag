
class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? password;
  int? zarapoints;
  int? goldapoints;
  int? rebarpoints;
  bool? zaramember;
  bool? goldamember;
  bool? rebarmember;
  int? points;



  UserModel({this.uid, this.email, this.firstName, this.secondName, this.password,this.zarapoints,this.goldapoints,this.rebarpoints,
  this.goldamember,this.rebarmember,this.zaramember,this.points});
  //receive data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName:  map['firstName'],
      secondName: map['secondName'],
      password: map['password'],
      zarapoints: map['zarapoints'],
      goldapoints: map['goldapoints'],
      rebarpoints: map['rebarpoints'],
        goldamember: map['goldamember'],
        rebarmember: map['rebarmember'],
        zaramember: map['zaramember'],
        points: map['points']
    );
  }


  //sending data to our server
Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email' : email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
      'zarapoints' :zarapoints,
      'goldapoints': goldapoints,
      'rebarpoints': rebarpoints,
      'goldamember': goldamember,
      'rebarmember': rebarmember,
      'zaramember': zaramember,
      'points' : points,
    };
}
}