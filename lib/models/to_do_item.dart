class RepeatOption {
  String value;

  RepeatOption(this.value);

  static RepeatOption never = RepeatOption("Never");
  static RepeatOption everyday = RepeatOption("Everyday");
  static RepeatOption everyWeek = RepeatOption("Every Week");
  static RepeatOption everyMonth = RepeatOption("Every Month");
  static RepeatOption everyYear = RepeatOption("Every Year");
}

class ToDoItem {
  int? id;
  String title;
  DateTime reminderTime;
  RepeatOption repeatOption;
  DateTime? startTime;
  DateTime? endTime;
  bool isImportant;
  int? categoryId;
  String? description;

  ToDoItem({
    this.id,
    required this.title,
    required this.reminderTime,
    required this.repeatOption,
    this.startTime,
    this.endTime,
    this.isImportant = false,
    this.categoryId,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'reminderTime': reminderTime.millisecondsSinceEpoch,
      'repeatOption': repeatOption.value,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'isImportant': isImportant ? 1 : 0,
      'categoryId': categoryId,
      'description': description
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      reminderTime: DateTime.fromMillisecondsSinceEpoch(map['reminderTime']),
      repeatOption: RepeatOption(map['repeatOption']),
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      isImportant: map['isImportant'] == 1,
      categoryId: map['categoryId'],
      description: map['description'],
    );
  }
}
