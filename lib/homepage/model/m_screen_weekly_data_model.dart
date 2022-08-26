class M_ScreenWeeklyDataModel {
  List<Data_weekly>? data;
  bool? error;
  String? statusCode;
  String? message;

  M_ScreenWeeklyDataModel(
      {this.data, this.error, this.statusCode, this.message});

  M_ScreenWeeklyDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_weekly>[];
      json['data'].forEach((v) {
        data!.add(new Data_weekly.fromJson(v));
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

class Data_weekly {
  String? id;
  String? fullName;
  String? username;
  String? image;
  User? user;
  List<Days_weekly>? days;

  Data_weekly(
      {this.id,
        this.fullName,
        this.username,
        this.image,
        this.user,
        this.days});

  Data_weekly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    image = json['image'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['days'] != null) {
      days = <Days_weekly>[];
      json['days'].forEach((v) {
        days!.add(new Days_weekly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['image'] = this.image;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? username;
  String? phone;
  String? countryCode;
  String? email;
  String? gender;
  String? image;
  String? levels;
  String? type;

  User(
      {this.id,
        this.fullName,
        this.username,
        this.phone,
        this.countryCode,
        this.email,
        this.gender,
        this.image,
        this.levels,
        this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    levels = json['levels'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['countryCode'] = this.countryCode;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['levels'] = this.levels;
    data['type'] = this.type;
    return data;
  }
}

class Days_weekly {
  String? id;
  String? userId;
  String? mbId;
  String? methodName;
  String? pauses;
  String? totalPauses;
  String? totalTime;
  String? sets;
  String? numberOfSets;
  String? createdDate;
  String? updatedDate;
  String? pausesSum;
  String? totalPausesSum;
  String? totalTimeSum;

  Days_weekly(
      {this.id,
        this.userId,
        this.mbId,
        this.methodName,
        this.pauses,
        this.totalPauses,
        this.totalTime,
        this.sets,
        this.numberOfSets,
        this.createdDate,
        this.updatedDate,
        this.pausesSum,
        this.totalPausesSum,
        this.totalTimeSum});

  Days_weekly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    mbId = json['mbId'];
    methodName = json['methodName'];
    pauses = json['pauses'];
    totalPauses = json['totalPauses'];
    totalTime = json['totalTime'];
    sets = json['sets'];
    numberOfSets = json['numberOf_sets'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    pausesSum = json['pauses_sum'];
    totalPausesSum = json['totalPauses_sum'];
    totalTimeSum = json['totalTime_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['mbId'] = this.mbId;
    data['methodName'] = this.methodName;
    data['pauses'] = this.pauses;
    data['totalPauses'] = this.totalPauses;
    data['totalTime'] = this.totalTime;
    data['sets'] = this.sets;
    data['numberOf_sets'] = this.numberOfSets;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['pauses_sum'] = this.pausesSum;
    data['totalPauses_sum'] = this.totalPausesSum;
    data['totalTime_sum'] = this.totalTimeSum;
    return data;
  }
}