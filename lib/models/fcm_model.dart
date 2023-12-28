class FcmNotificationModel {
  String? title;
  String? body;

  FcmNotificationModel({this.title, this.body});

  FcmNotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class NotificationDataModel {
  String? status;
  String? event;
  String? orderID;

  NotificationDataModel({this.status, this.event, this.orderID});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    event = json['Event'];
    orderID = json['OrderID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Event'] = this.event;
    data['OrderID'] = this.orderID;
    return data;
  }
}