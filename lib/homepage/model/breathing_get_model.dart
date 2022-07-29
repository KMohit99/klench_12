class BreathingGetModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  BreathingGetModel({this.data, this.error, this.statusCode, this.message});

  BreathingGetModel.fromJson(Map<String, dynamic> json) {
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
  String? levels;
  String? sets;

  Data({this.id, this.levels, this.sets});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levels = json['levels'];
    sets = json['sets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['levels'] = this.levels;
    data['sets'] = this.sets;
    return data;
  }
}