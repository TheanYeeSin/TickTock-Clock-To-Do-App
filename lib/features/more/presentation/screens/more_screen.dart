import "package:flutter/material.dart";
import "package:ticktock/core/constants/path.dart";

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Image.asset("assets/logos/logo_b_256x256.png"),
                ),
              ),
              Divider(color: Colors.grey.shade400, height: 4, thickness: 2),
              ListTile(
                leading: const Icon(Icons.tag_outlined),
                title: const Text("Categories"),
                onTap: () => Navigator.pushNamed(context, categorySettingPath),
              ),
              ListTile(
                leading: const Icon(Icons.backup_outlined),
                title: const Text("Backup & Restore"),
                onTap: () {},
              ),
              Divider(color: Colors.grey.shade400, height: 4, thickness: 2),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text("Settings"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.info_outlined),
                title: const Text("About"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text("Help"),
                onTap: () {},
              ),
            ],
          ),
        ),
      );
}
