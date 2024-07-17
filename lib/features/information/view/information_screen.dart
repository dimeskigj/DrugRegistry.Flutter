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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Информации',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) => Text(
                      'Верзија ${snapshot.data?.version}+${snapshot.data?.buildNumber}',
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: 'Ова е '),
                        TextSpan(
                          text: 'неофицијална ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              'мобилна апликација за македонскиот регистар на лекови. ',
                        ),
                        const TextSpan(
                          text:
                              'Оваа апликација не е поврзана со ниту една државна институција и е направена од независно лице. Информациите за лекови и аптеки се влечат од ',
                        ),
                        TextSpan(
                          text: Constants.lekoviUrl,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrlString(
                                  Constants.lekoviUrl,
                                ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
              height: 0,
            ),
            OutlinedButton.icon(
              onPressed: () => launchUrlString('mailto:dimeskigj@gmail.com'),
              label: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Контакт',
                ),
              ),
              icon: const Icon(
                Icons.mail,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => launchUrlString(Constants.privacyPolicyUrl),
              label: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Политика за приватност',
                ),
              ),
              icon: const Icon(
                Icons.launch,
              ),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
