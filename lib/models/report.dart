class Report {
  final String id;
  final String title;
  final String description;

  Report({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json['id'].toString(),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
