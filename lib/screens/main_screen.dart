import 'package:flutter/material.dart';
import 'package:tick_tock/constants/color.dart';
import 'package:tick_tock/widgets/to_do_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                color: appBarIconColor,
                size: 30,
              ),
              Icon(Icons.more_horiz, color: appBarIconColor, size: 30)
            ],
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            //TODO: Clock UI
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All to-dos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text("9999 to-dos")
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const Text("TOMORROW"),
                  ),
                  const ToDoItem(iconColor: toDoGreen, toDoTitle: "Test1"),
                  const ToDoItem(iconColor: toDoRed, toDoTitle: "Test2"),
                  const ToDoItem(iconColor: toDoBlue, toDoTitle: "Test3"),
                  const ToDoItem(iconColor: toDoYellow, toDoTitle: "Test4"),
                  const ToDoItem(iconColor: toDoPurple, toDoTitle: "Test5"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
