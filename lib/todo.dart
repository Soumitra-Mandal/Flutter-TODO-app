class Todo {
  final String id;
  final String title;
  final String description;
  final String createdOn;
  final int priority;

  const Todo(
      this.id, this.title, this.description, this.createdOn, this.priority);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'priority': priority
    };
  }

  static fromJson(Map<String, dynamic> parsedJson) {
    return Todo(
        parsedJson['id'],
        parsedJson['title'],
        parsedJson['description'],
        parsedJson['createdOn'],
        parsedJson['priority']);
  }
}
