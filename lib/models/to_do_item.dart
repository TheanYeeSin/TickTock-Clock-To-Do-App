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
}
