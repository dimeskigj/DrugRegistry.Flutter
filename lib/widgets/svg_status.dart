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
        margin: const EdgeInsets.fromLTRB(10, 100, 20, 20),
        child: Column(
          children: [
            SvgPicture.asset(
              assetName,
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 15),
              child: Text(
                headline,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            if (body != null)
              Text(
                body!,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
