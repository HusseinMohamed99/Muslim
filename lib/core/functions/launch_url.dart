part of './../helpers/export_manager/export_manager.dart';

Future<void> _launchURL(String url) async {
  !await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  {
    throw Exception('لا يمكن فتح الرابط $url');
  }
}
