import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgStatus extends StatelessWidget {
  final String assetName;
  final String headline;
  final String? body;

  const SvgStatus({super.key, required this.assetName, required this.headline, this.body});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            SvgPicture.asset(
              assetName,
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                headline,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            if (body != null)
              Text(
                body!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
