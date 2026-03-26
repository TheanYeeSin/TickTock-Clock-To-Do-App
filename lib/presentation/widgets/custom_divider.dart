import "package:flutter/material.dart";

class CustomDivider extends StatelessWidget {
  final double symmetricPadding;
  final double dividerHeight;
  final double dividerThickness;
  const CustomDivider({
    super.key,
    required this.symmetricPadding,
    required this.dividerHeight,
    required this.dividerThickness,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: symmetricPadding),
        child: Divider(height: dividerHeight, thickness: dividerThickness),
      );
}
