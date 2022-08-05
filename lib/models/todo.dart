import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app_with_flutter_and_firebase/models/task.dart';

part 'todo.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class Todo {
  @JsonKey(name: 'uuid', nullable: false)
  String uuid;

  @JsonKey(name: "todo_title", nullable: false)
  String todoTitle;
  @JsonKey(name: "todo_type", nullable: false)
  String todoType;

  @JsonKey(name: "todo_time", nullable: false)
  String todoTime;

  @JsonKey(name: "todo_place", nullable: false)
  String todoPlace;

  @JsonKey(name: "todo_notify", nullable: false)
  String todoNotfication;

  @JsonKey(name: "task_list", nullable: false)
  List<Task> taskList;

  Todo();

  factory Todo.fromJson(Map<String, dynamic> data) => _$TodoFromJson(data);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
