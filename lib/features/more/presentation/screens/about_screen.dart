import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:ticktock/core/constants/url.dart";
import "package:ticktock/core/utils/url/launch_url_string.dart";
import "package:ticktock/features/more/presentation/widgets/app_logo.dart";

/// AboutScreen: Screen for displaying information about the app
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // ----- Fields -----
  String? _version;

  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  // ----- Load Version -----
  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _version = info.version);
  }

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("About")),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: AppLogo(),
            ),
            Divider(color: Colors.grey.shade400, height: 4, thickness: 2),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("App Version"),
              subtitle: Text(_version ?? "Unknown"),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text("Privacy Policy"),
              onTap: () async {
                await launchUrlString(
                  "$projectGithubUrl/blob/main/README.md#privacy-policy",
                );
              },
              trailing: const Icon(Icons.chevron_right_outlined),
            ),
            ListTile(
              leading: const Icon(Icons.copyright_outlined),
              title: const Text("License"),
              onTap: () async {
                await launchUrlString(
                  "$projectGithubUrl/blob/main/LICENSE",
                );
              },
              trailing: const Icon(Icons.chevron_right_outlined),
            ),
            const SizedBox(height: 24),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Made with ❤️ by ",
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Thean Yee Sin",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrlString(
                            authorGithubUrl,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
