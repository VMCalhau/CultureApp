import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String origem, String destino) async {
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${origem}&destination=${destino}&key=AIzaSyD5KKt9qtVfyEKrxd_T1T3Y8SXHlp-MV8Y";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}