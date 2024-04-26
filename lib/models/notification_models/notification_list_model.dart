import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  bool? success;
  String? message;
  int? totalUnseen;
  int? total;
  List<NotificationDetail>? notification;

  NotificationListModel({
    this.success,
    this.message,
    this.totalUnseen,
    this.total,
    this.notification,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    success: json["success"],
    message: json["message"],
    totalUnseen: json["total_unseen"],
    total: json["total"],
    notification: json["notification"] == null ? [] : List<NotificationDetail>.from(json["notification"]!.map((x) => NotificationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total_unseen": totalUnseen,
    "total": total,
    "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class NotificationDetail {
  String? notificationType;
  String? title;
  String? message;
  int? isSeen;
  String? createdAt;

  NotificationDetail({
    this.notificationType,
    this.title,
    this.message,
    this.isSeen,
    this.createdAt,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    notificationType: json["notification_type"],
    title: json["title"],
    message: json["message"],
    isSeen: json["is_seen"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "notification_type": notificationType,
    "title": title,
    "message": message,
    "is_seen": isSeen,
    "created_at": createdAt,
  };
}
