class Category {
  int? id;
  String color;
  String name;

  Category({
    this.id,
    required this.color,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'color': color, 'name': name};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      color: map['color'],
      name: map['name'],
    );
  }
}
