// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo()
    ..uuid = json['uuid'] as String
    ..todoTitle = json['todo_title'] as String
    ..todoPlace = json['todo_place'] as String
    ..todoNotfication = json['todo_notify'] as String
    ..todoTime = json['todo_time'] as String
    ..todoType = json['todo_type'] as String
    ..taskList = (json['task_list'] as List)
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'todo_title': instance.todoTitle,
      'todo_time': instance.todoTime,
      'todo_type': instance.todoType,
      'todo_place': instance.todoPlace,
      'todo_notify': instance.todoNotfication,
      'task_list': instance.taskList.map((e) => e.toJson()).toList(),
    };
