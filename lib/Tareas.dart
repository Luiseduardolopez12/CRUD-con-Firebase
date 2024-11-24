class Task {
  String id;
  String title;
  String description;

  Task({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  static Task fromMap(String id, Map<String, dynamic> map) {
    return Task(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
