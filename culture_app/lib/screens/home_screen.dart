import 'dart:convert';
import 'package:culture_app/common/custom_drawer.dart';
import 'package:culture_app/models/Location.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    _getKeywords().then((value) {
      if (value != null) {
        print(value.localizacao);
      }
    });
  }

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
        return Container(color: Colors.green);
      }),
    );
  }
}
