class AppNotification {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime? createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        id: json['id'].toString(),
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        isRead: json['isRead'] ?? json['read'] ?? false,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'isRead': isRead,
        'createdAt': createdAt?.toIso8601String(),
      };
}
