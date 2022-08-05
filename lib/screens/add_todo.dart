import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/models/task.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/constant.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _notification = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<Task> _taskList = [Task.fromJson({})];
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
  }

  List<String> countries = ["Business", "Personal"];

  String dropdownvalue = 'Business', dropValue;
  Size deviceSize;
  String todoType, todoValue, todoPlace, todoTime, todoNotification;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /*floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          label: Text("Add Task"),
          icon: Icon(Icons.add),
          onPressed: () {
            if (_taskList.last.taskDescription == null ||
                _taskList.last.taskDescription.trim().isEmpty) {
              Fluttertoast.showToast(msg: "Please enter task");
            } else {
              setState(
                () {
                  _taskList.add(Task.fromJson({}));
                },
              );
            }
          },
        ),*/
        appBar: AppBar(
          backgroundColor: Constant.defaultTheme().primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text("Add new Thing"),
          actions: [
            /*IconButton(
              icon: Icon(
                Icons.save,
                size: 35,
              ),
              color: Colors.greenAccent,
              onPressed: () => submit(context),
            ),*/
            IconButton(
              icon: Icon(
                Icons.tune,
                color: Colors.blue,
                size: 35,
              ),
              // color: Colors.redAccent,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Constant.defaultTheme().primaryColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Constant.defaultTheme().primaryColor,
                        child: IconButton(
                            color: Colors.lightBlue,
                            padding: const EdgeInsets.all(20),
                            iconSize: 50,
                            icon: const Icon(Icons.design_services),
                            onPressed: () {
                              // do something
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .86,
                          // alignment: Alignment.center,
                          child: DropdownButtonFormField(
                            dropdownColor: Constant.defaultTheme().primaryColor,
                            items: countries.map((state) {
                              return DropdownMenuItem(
                                child: Text(
                                  '$state',
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: state,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownvalue = value;
                              });
                            },
                            value: dropdownvalue,
                            validator: (value) =>
                                value == null ? 'Choose a state' : null,
                          ),
                        ),
                      ],
                    ),
                    _buildTextFormField(
                        hint: "Add a Todo item",
                        controller: _title,
                        errorTxt: 'Enter a Todo Item'),
                    _buildTextFormField(
                        hint: "Place",
                        controller: _place,
                        errorTxt: 'Enter a Place'),
                    TextFormField(
                      controller: _time,
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: null,
                      // inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      autofocus: false,
                      readOnly: true,
                      // cursorColor: Colors.blue,
                      decoration: InputDecoration(
                          hintText: 'Time',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onTap: () {
                        _selectTime(context);
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please Select Time';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                        hint: "Notification",
                        controller: _notification,
                        errorTxt: 'Enter a Notification'),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(
                              40), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {
                          submit(context);
                        },
                        child: Text("Add your Thing"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      {String hint, String errorTxt, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      textAlign: TextAlign.start,
      maxLines: null,
      // inputFormatters: [LengthLimitingTextInputFormatter(50)],
      autofocus: false,
      // cursorColor: Colors.blue,
      decoration: InputDecoration(
          hintText: hint, hintStyle: TextStyle(color: Colors.grey)),
      validator: (value) {
        if (value.trim().isEmpty) {
          return errorTxt;
        }
        return null;
      },
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        _time.text = selectedTime.format(context);
        selectedTime = timeOfDay;
      });
    }
  }

  submit(BuildContext context) {
    todoType = dropdownvalue;
    todoValue = _title.text.toString();
    todoPlace = _place.text.toString();
    todoTime = _time.text.toString();
    todoNotification = _notification.text.toString();
    if (_formKey.currentState.validate()) {
      Todo todo = new Todo();
      todo.todoTitle = _title.text;
      todo.todoTime = todoTime;
      todo.todoPlace = todoTime;
      todo.todoType = todoType;
      todo.todoPlace = todoPlace;
      todo.todoNotfication = todoNotification;
      todo.taskList = _taskList;

      TodoService().add(todo.toJson());
      Navigator.pop(context);
    }
  }
}
