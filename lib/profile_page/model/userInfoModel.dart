class UserInfoModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  UserInfoModel({this.data, this.error, this.statusCode, this.message});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? username;
  String? phone;
  String? email;
  String? dob;
  String? gender;
  String? image;
  String? createdDate;

  Data(
      {this.id,
        this.username,
        this.phone,
        this.email,
        this.dob,
        this.gender,
        this.image,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    image = json['image'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['createdDate'] = this.createdDate;
    return data;
  }
}