import "package:flutter/material.dart";

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("More"),
        ),
        body: const Center(
          child: Text("More Screen"),
        ),
      );
}
