class Exercise {
  Exercise({required this.id, required this.name, required this.description, required this.tags});

  final String id;
  final String name;
  final String description;
  final List<String> tags;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  /// Converts this Exercise object into a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'tags': tags};
  }
}
