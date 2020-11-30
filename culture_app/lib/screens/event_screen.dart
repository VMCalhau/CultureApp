import 'package:culture_app/models/Event.dart';
import 'package:culture_app/models/MapUtils.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:culture_app/models/Location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventScreen extends StatefulWidget {
  final Event evento;
  EventScreen({Key key, @required this.evento}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState(evento: evento);
}

class _EventScreenState extends State<EventScreen> {
  final Event evento;
  _EventScreenState({Key key, @required this.evento});

  Future<Location> _getKeywords() async {
    http.Response response;

    response = await http.post(
      'https://api.textrazor.com/',
      headers: <String, String>{
        'x-textrazor-key':
        '276d983152cd9c7833f826402ac07459a2aea3d64ff1b1b08db75c80',
        'Accept-encoding': 'gzip'
      },
      body: <String, String>{
        'text': evento.descricao,
        'extractors': 'entities'
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
        evento.localizacao = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Image.network(
                    evento.imagem,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, loading) {
                      if (loading == null) return child;
                      return Center(child: CircularProgressIndicator(),);
                    },
                  ),
                  SizedBox(height: 16.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(evento.nome, style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20.0,
                    ),),
                  ),
                  Divider(
                    height: 32, thickness: 5, indent: 12.0, endIndent: 12.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(evento.descricao + "...", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),),
                  ),
                  SizedBox(height: 20.0,),
                  MaterialButton(
                    height: 48.0,
                    color: Color(0xFF2E86C1),
                    textColor: Colors.white,
                    child: Text("Saiba mais", style: TextStyle(
                      fontSize: 15.0,
                    ),),
                    onPressed: () => _launchUrl(),
                  ),
                  SizedBox(height: 24.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: MaterialButton(
                      height: 48.0,
                      color: Color(0xFF2E86C1),
                      textColor: Colors.white,
                      child: Text("Abrir no Google Maps", style: TextStyle(
                        fontSize: 15.0,
                      ),),
                      onPressed: () {
                        MapUtils.openMap(model.userData["cep"], evento.localizacao.localizacao);
                      },
                    ),
                  )
                ],
              )
          );
        })
    );
  }

  _launchUrl() async {
    const url = "https://campinas.com.br/agenda/lagoa-do-taquaral-tera-varias-atividades-na-manha-de-combate-ao-sedentarismo-no-domingo-22/";
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw "Não foi possível abrir o site";
    }
  }
}


