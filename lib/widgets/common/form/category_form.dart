import 'package:flutter/material.dart';
import 'package:tick_tock/models/category.dart';
import 'package:tick_tock/database/database_service.dart';
import 'package:tick_tock/utils/picker_item.dart';
import 'package:tick_tock/utils/validator.dart';
import 'package:tick_tock/widgets/common/custom_form_field.dart';
import 'package:tick_tock/widgets/common/custom_picker.dart';

// Category Form
class CategoryForm extends StatefulWidget {
  final Category? category;
  const CategoryForm({super.key, this.category});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final iconController = TextEditingController();
  final colorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategoryData();
  }

  _loadCategoryData() async {
    if (widget.category != null) {
      categoryNameController.text = widget.category!.name;
      iconController.text = widget.category!.icon;
      colorController.text = widget.category!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //-----Category Name-----
              CustomFormField(
                controller: categoryNameController,
                hintText: "Category Name",
                errorText: "Required",
                prefixIcon: const Icon(Icons.catching_pokemon_outlined),
                readOnly: false,
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
              ),
              CustomPicker<String>(
                margin: const EdgeInsets.only(bottom: 16),
                crossAxisCount: 7,
                initialValue: colorController.text,
                items: colors,
                onItemSelected: (selectedColor) {
                  setState(() {
                    colorController.text = selectedColor;
                  });
                },
              ),
              CustomPicker<String>(
                initialValue: iconController.text,
                crossAxisCount: 7,
                items: icons,
                onItemSelected: (selectedIcon) {
                  setState(() {
                    iconController.text = selectedIcon;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final name = categoryNameController.value.text.trim();
            final color = colorController.value.text.trim();
            final icon = iconController.value.text.trim();

            final Category newCategory = Category(
              id: widget.category?.id,
              name: name,
              icon: icon,
              color: color,
            );
            if (widget.category == null) {
              await DatabaseService.addCategory(newCategory);
            } else {
              await DatabaseService.updateCategory(newCategory);
            }
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
