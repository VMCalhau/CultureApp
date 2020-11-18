import 'dart:convert';
import 'package:culture_app/common/custom_drawer.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<Map> getKeywords() async {
    http.Response response;

    response = await http.post(
      'https://api.textrazor.com/',
      headers: <String, String> {
        'x-textrazor-key':'276d983152cd9c7833f826402ac07459a2aea3d64ff1b1b08db75c80',
        'Accept-encoding':'gzip'
      },
      body: <String, String> {
        'text':'O Museu de Ciencia em Campinas vai promover um evento...',
        'extractors':'topics'
      },
    );
    if (response.statusCode != 200)
      print('error: ' + response.statusCode.toString());
    print(response.body);
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
        return Container(color: Colors.green,
        child: Center(
          child: RaisedButton(
            onPressed: getKeywords,
          ),
        ),);
      }),
    );
  }
}
