import "package:flutter/material.dart";
import "package:ticktock/features/category/domain/category.dart";
import "package:ticktock/features/category/presentation/widgets/category_form.dart";

// Category form screen
class CategoryFormScreen extends StatefulWidget {
  final Category? category;
  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category == null ? "Add Category" : "Edit Category",
          ),
        ),
        body: CategoryForm(category: widget.category),
      );
}
