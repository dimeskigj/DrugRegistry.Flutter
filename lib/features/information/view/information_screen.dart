import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Информации',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Text(
                      'Верзија ${snapshot.data?.version}+${snapshot.data?.buildNumber}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: theme.textTheme.bodyLarge,
                    children: [
                      const TextSpan(text: 'Ова е '),
                      TextSpan(
                        text: 'неофицијална ',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text:
                            'мобилна апликација за македонскиот регистар на лекови. ',
                      ),
                      const TextSpan(
                        text:
                            'Оваа апликација не е поврзана со ниту една државна институција и е направена од независно лице. Информациите за лековите и аптеките се влечат од ',
                      ),
                      TextSpan(
                        text: Constants.lekoviUrl,
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap =
                                  () => launchUrlString(Constants.lekoviUrl),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                OutlinedButton.icon(
                  onPressed:
                      () => launchUrlString('mailto:dimeskigj@gmail.com'),
                  label: const Text(
                    'Контакт',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.mail),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    side: BorderSide(color: theme.primaryColor),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => launchUrlString(Constants.privacyPolicyUrl),
                  label: const Text(
                    'Политика за приватност',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.launch),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    side: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
