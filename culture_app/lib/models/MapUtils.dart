import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String origem, String destino) async {
    //String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${origem}&destination=${destino}&key=AIzaSyBD--zsG3PZBnOP08pqXEueR8LTQ5PIn60";
    String url = 'https://www.google.com/maps/dir/?api=1&origin=${origem}&destination=${destino}&travelmode=driving&dir_action=navigate';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}