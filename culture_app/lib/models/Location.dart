class Location {
  String localizacao;

  Location(this.localizacao);

  factory Location.fromJson(Map<String,dynamic> json) {

    for (int i = 0; i < json['response']['entities'].length; i++) {
      if (json['response']['entities'][i]['freebaseTypes'].toString() == '[/location/location]')
        return Location(json['response']['entities'][i]['matchedText'].toString());
        //print(json['response']['entities'][i]['matchedText']);
    }

    return null;
  }
}