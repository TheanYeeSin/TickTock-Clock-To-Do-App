import "package:flutter/material.dart";
import "package:ticktock/core/database/database_service.dart";
import "package:ticktock/core/types/time.dart";
import "package:ticktock/core/utils/color.dart";
import "package:ticktock/features/category/presentation/screens/category_settings_screen.dart";
import "package:ticktock/features/to_do/domain/to_do.dart";
import "package:ticktock/features/to_do/presentation/widgets/to_do_item_tile.dart";
import "package:ticktock/presentation/widgets/clock/clock.dart";
import "package:timer_builder/timer_builder.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<ToDo>?> _getAllToDos() => DatabaseService.getAllToDos();

  @override
  Widget build(final BuildContext context) => Scaffold(
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
              FutureBuilder<List<ToDo>?>(
                future: _getAllToDos(),
                builder:
                    (final context, final AsyncSnapshot<List<ToDo>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong! Error: ${snapshot.error}",
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return TimerBuilder.periodic(
                      const Duration(seconds: 1),
                      builder: (final context) {
                        var currentTime = DateTime.now();
                        String second = currentTime.second < 10
                            ? "0${currentTime.second}"
                            : "${currentTime.second}";
                        String minute = currentTime.minute < 10
                            ? "0${currentTime.minute}"
                            : "${currentTime.minute}";
                        String hour = currentTime.hour < 10
                            ? "0${currentTime.hour}"
                            : "${currentTime.hour}";
                        return Column(
                          children: [
                            Center(
                              child: Clock(
                                time: TimeModel(
                                  currentTime.hour,
                                  currentTime.minute,
                                  currentTime.second,
                                ),
                                toDoItems: snapshot.data,
                              ),
                            ),
                            Center(
                              child: Text("$hour:$minute:$second"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text("No To Do Items"),
                  );
                },
              ),
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
                child: FutureBuilder<List<ToDo>?>(
                  future: _getAllToDos(),
                  builder: (final context,
                      final AsyncSnapshot<List<ToDo>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Something went wrong! Error: ${snapshot.error}",
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        itemBuilder: (final context, final index) => ToDoTile(
                          iconColor: toDoGreen,
                          toDoItem: snapshot.data![index],
                          onDelete: () async {
                            showDialog(
                              context: context,
                              builder: (final context) => AlertDialog(
                                title: const Center(
                                  child: Text(
                                    "Delete To-do",
                                  ),
                                ),
                                content: const Text(
                                  "Are you sure you want to delete this to-do?",
                                ),
                                actions: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "NO",
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await DatabaseService.deleteToDo(
                                            snapshot.data![index],
                                          );
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text(
                                          "YES",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
                builder: (final context) => const CategorySettingsScreen(),
              ),
            );
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      );
}
