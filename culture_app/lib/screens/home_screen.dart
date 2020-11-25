import 'dart:convert';
import 'dart:ffi';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_app/common/custom_drawer.dart';
import 'package:culture_app/models/Event.dart';
import 'package:culture_app/models/Location.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<Location> _getKeywords() async {
    http.Response response;

    response = await http.post(
      'https://api.textrazor.com/',
      headers: <String, String> {
        'x-textrazor-key':'276d983152cd9c7833f826402ac07459a2aea3d64ff1b1b08db75c80',
        'Accept-encoding':'gzip'
      },
      body: <String, String> {
        'text':'Neste mês de outubro, quando se comemora o Dia das Crianças, o Museu Catavento traz a mostra gratuita de experiências científicas ao Parque D. Pedro Shopping, em Campinas. A exposição começou dia 3 e vai …',
        'extractors':'entities'
      },
    );
    if (response.statusCode != 200)
      print('error: ' + response.statusCode.toString());
    else {
      return Location.fromJson(jsonDecode(response.body));
    }
  }

  /*@override
  void initState() {
    super.initState();
    _getKeywords().then((value) {
      if (value != null) {
        print(value.localizacao);
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading)
          return  Center(child: CircularProgressIndicator(),);
        else if (!model.isLogged())
          return Container(child: Center(child: Text("Cadastre-se ou Entre para visualizar eventos"),),);
        else {
          _getPreferences(model.firebaseUser.uid).then((value) {
              _getEvents(value);
          });
          /*return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            itemCount: 10,
            itemBuilder: (context, index) {

            },
          );*/
          return Container();
        }
      }),
    );
  }

  Future<List<dynamic>> _getPreferences(userUid) async {
    DocumentSnapshot doc = await Firestore.instance.collection("users").document(userUid).get();
    return doc.data['preferencias'];
  }

  void _getEvents(List<dynamic> value) async {
    /*int totalPorPagina = 10;
    int numEventosDiferentes = value.length;

    int eventosCadaTipo = (totalPorPagina / numEventosDiferentes).floor();*/

    //for (dynamic d in value) {
        String url = "https://www.googleapis.com/customsearch/v1?key=AIzaSyD5KKt9qtVfyEKrxd_T1T3Y8SXHlp-MV8Y&cx=3081b61d9d620724c&q=" + value[0].toString() + "+campinas&linkSite&sort=date";

        http.Response response = await http.get(url);

        if (response.statusCode == 200) {
          //log(jsonDecode(response.body)["items"][0].toString());

          List<Event> eventosUmTipo = [];
          Map<String, dynamic> mapa = jsonDecode(response.body);

          for (int i = 0; i < mapa["items"].length; i++) {
            if (mapa["items"][i]["pagemap"]["metatags"][0]["og:title"].length > 50 && mapa["items"][i]["pagemap"]["metatags"][0]["og:description"].length > 50) {
                eventosUmTipo.add(new Event(mapa["items"][i]["pagemap"]["metatags"][0]["og:title"], mapa["items"][i]["pagemap"]["metatags"][0]["og:description"], mapa["items"][i]["pagemap"]["metatags"][0]["og:url"], mapa["items"][i]["pagemap"]["metatags"][0]["og:image"], null));
            }
          }
          print(eventosUmTipo.length);
        }
    //}
  }

}
