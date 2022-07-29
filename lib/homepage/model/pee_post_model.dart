class PeePostModel {
  List<User>? user;
  bool? error;
  String? statusCode;
  String? message;

  PeePostModel({this.user, this.error, this.statusCode, this.message});

  PeePostModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? id;
  String? userId;

  User({this.id, this.userId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    return data;
  }
}