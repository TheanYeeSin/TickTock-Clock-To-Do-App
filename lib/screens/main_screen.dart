import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tick_tock/database/database_service.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/utils/color.dart';
import 'package:tick_tock/screens/to_do_manage_screen.dart';
import 'package:tick_tock/widgets/common/custom_divider.dart';
import 'package:tick_tock/widgets/to_do_item_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<ToDoItem>?> _getAllToDoItems() {
    return DatabaseService.getAllToDoItems();
  }

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
            Icon(Icons.more_horiz, color: appBarIconColor, size: 30),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO: Clock UI
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All to-dos",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("9999 to-dos"),
                  SizedBox(height: 20),
                  Text("TOMORROW"),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<List<ToDoItem>?>(
                future: _getAllToDoItems(),
                builder: (context, AsyncSnapshot<List<ToDoItem>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong! Error: ${snapshot.error}',
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ToDoItemTile(
                          iconColor: toDoGreen,
                          toDoItem: snapshot.data![index],
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                  return const Center(
                    child: Text("No To Do Items"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ToDoManageScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
