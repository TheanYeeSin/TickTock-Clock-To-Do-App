import "package:flutter/material.dart";
import "package:ticktock/core/constants/path.dart";
import "package:ticktock/features/more/presentation/widgets/app_logo.dart";

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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: AppLogo(),
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
                onTap: () => Navigator.pushNamed(context, aboutPath),
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
