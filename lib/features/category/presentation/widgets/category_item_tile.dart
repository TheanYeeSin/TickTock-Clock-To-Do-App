import "package:flutter/material.dart";
import "package:tick_tock/features/category/domain/category.dart";

// Category setting list tile widget
class CategoryItemTile extends StatelessWidget {
  final Category category;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryItemTile({
    super.key,
    required this.category,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: Card(
          elevation: 8,
          child: InkWell(
            onDoubleTap: onEdit,
            onLongPress: onDelete,
            child: Ink(
              child: ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                title: Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: onDelete,
                ),
              ),
            ),
          ),
        ),
      );
}
