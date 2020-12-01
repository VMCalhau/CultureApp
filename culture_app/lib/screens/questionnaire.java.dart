import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Questionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionário"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text("Ei, se tiver um tempinho, clica no link aqui embaixo para responder algumas perguntinhas! É super rápido e ajuda bastatnte a gente ;)", style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),),
          ),
          SizedBox(height: 16.0,),
          FlatButton(
            child: Text("https://forms.gle/WEMdpt1BVpgaeYSB9", style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16.0
            ),),
            onPressed: _launchUrl,
          ),
        ],
      ),
    );
  }

  _launchUrl() async {
    const url = "https://forms.gle/WEMdpt1BVpgaeYSB9";
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw "Não foi possível abrir o site";
    }
  }
}
