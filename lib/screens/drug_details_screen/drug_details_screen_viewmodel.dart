import 'package:url_launcher/url_launcher.dart';

import '../view_model_base.dart';

class DrugDetailsScreenViewModel extends ViewModelBase {
  Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
