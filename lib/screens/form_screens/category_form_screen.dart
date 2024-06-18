import 'package:tick_tock/widgets/common/form/category_form.dart';
import 'package:flutter/material.dart';
import 'package:tick_tock/models/category.dart';

// Category form screen
class CategoryFormScreen extends StatefulWidget {
  final Category? category;
  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null ? "Add Category" : "Edit Category",
        ),
      ),
      body: CategoryForm(category: widget.category),
    );
  }
}
