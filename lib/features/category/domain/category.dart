class Category {
  int? id;
  String icon;
  String color;
  String name;

  Category({
    this.id,
    required this.icon,
    required this.color,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'icon': icon, 'color': color, 'name': name};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      icon: map['icon'],
      color: map['color'],
      name: map['name'],
    );
  }
}
