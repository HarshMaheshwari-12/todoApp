import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/add_todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int backPressCounter = 0;
  int selectedExpansionTile = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          /*appBar: AppBar(
            backgroundColor: Constant.defaultTheme().primaryColor,
            title: Text("Todo list"),
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //       Icons.login,
            //       color: Colors.redAccent,
            //     ),
            //     onPressed: () {
            //       AuthService.logout();
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => LoginScreen(),
            //           settings: RouteSettings(name: '/login'),
            //         ),
            //         (Route<dynamic> route) => false,
            //       );
            //     },
            //   )
            // ],
          ),*/
          body: Stack(
            children: [
              Image.asset('assets/mountain.jpeg'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35).copyWith(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "INBOX",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    getTodoListBody(context),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 30,
                child: Text("Your \nThings",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w100)),
              ),
              Positioned(
                top: 220,
                left: 30,
                child: Text(now,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w100)),
              ),
              Positioned(
                top: 110,
                left: 230,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text("24",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w100)),
                        Text(
                          "Personal",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text("15",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w100)),
                        Text(
                          " Business",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(
              // label: Text(""),
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodo(),
                    settings: RouteSettings(name: '/add_todo'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getTodoListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TodoService().getTodoListOfCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        if (snapshot.hasError) {
          child = Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = Center(
            child: Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.data.size == 0) {
          child = Center(
            child: Text("All TODOs are caught up"),
          );
        } else if (snapshot.hasData && snapshot.data.size > 0) {
          child = Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Todo todo = Todo.fromJson(snapshot.data.docs[index].data());
                return ListTile(
                    leading: CircleAvatar(
                        radius: 40, child: Icon(Icons.design_services)),
                    subtitle: Text(
                      todo.todoPlace,
                      style: TextStyle(color: Colors.black),
                    ),
                    title: Text(todo.todoTitle),
                    trailing: Text(todo.todoTime,
                        style: TextStyle(color: Colors.grey)));
              },
            ),
          );
        }
        return child;
      },
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      backPressCounter++;
      Fluttertoast.showToast(msg: "Press again to exit !!!");
      Future.delayed(Duration(seconds: 2, milliseconds: 0), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
