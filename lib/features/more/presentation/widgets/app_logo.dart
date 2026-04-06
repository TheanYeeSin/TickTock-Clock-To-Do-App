import "package:flutter/material.dart";

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: 96,
        height: 96,
        child: Image.asset("assets/logos/logo_b_256x256.png"),
      );
}
