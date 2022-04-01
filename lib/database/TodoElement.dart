import 'package:hive/hive.dart';

part 'TodoElement.g.dart';

@HiveType(typeId: 2)
class TodoElement {
  TodoElement(this.name, [this.checked = false]);

  @HiveField(0)
  late String name;

  @HiveField(1)
  late bool checked;

  copyFrom(TodoElement other) {
    name = other.name;
    checked = other.checked;
  }
}
