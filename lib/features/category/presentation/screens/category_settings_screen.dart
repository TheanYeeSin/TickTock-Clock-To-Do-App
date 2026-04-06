import "package:flutter/material.dart";
import "package:ticktock/core/database/database_service.dart";
import "package:ticktock/features/category/domain/category.dart";
import "package:ticktock/features/category/presentation/screens/category_form_screen.dart";
import "package:ticktock/features/category/presentation/widgets/category_item_tile.dart";

// Categories setting screen
class CategorySettingsScreen extends StatefulWidget {
  const CategorySettingsScreen({super.key});

  @override
  State<CategorySettingsScreen> createState() => _CategorySettingsScreenState();
}

class _CategorySettingsScreenState extends State<CategorySettingsScreen> {
  Future<List<Category>?> _getAllCategory() =>
      // Return all categories
      DatabaseService.getAllCategories();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Category Settings"),
        ),
        body: FutureBuilder<List<Category>?>(
          future: _getAllCategory(),
          builder:
              (final context, final AsyncSnapshot<List<Category>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong! Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (final context, final index) => CategoryItemTile(
                  category: snapshot.data![index],
                  onDelete: () async {
                    await showDialog(
                      context: context,
                      builder: (final context) => AlertDialog(
                        title: const Center(
                          child: Text(
                            "Delete Category",
                          ),
                        ),
                        content: const Text(
                          "Are you sure you want to delete this category?",
                        ),
                        actions: [
                          OverflowBar(
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
                                  await DatabaseService.deleteCategory(
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
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (final context) => CategoryFormScreen(
                          category: snapshot.data![index],
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(
              child: Text("No Category Items"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (final context) => const CategoryFormScreen(),
              ),
            );
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      );
}
