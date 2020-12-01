import 'dart:convert';
import 'dart:ffi';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_app/common/custom_drawer.dart';
import 'package:culture_app/models/Event.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/scheduler.dart';

import 'event_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> preferencias = [];
  List<Event> allEvents = [];

  Widget _widget = Center(child: CircularProgressIndicator(),);

  int start = 1;
  ScrollController _scrollController = new ScrollController();

  void acessoAPI(context) {
    Future.delayed(Duration(seconds: 3), (){
      log(preferencias.toString());
      _getEvents(preferencias).then((value) {
        setState(() {
          _widget = _buildList(value);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => acessoAPI(context));
    }
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
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (!model.isLogged())
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Cadastre-se ou Entre para visualizar eventos"),
                SizedBox(height: 48.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: MaterialButton(
                    height: 48.0,
                    color: Color(0xFF2E86C1),
                    textColor: Colors.white,
                    child: Text("Entrar", style: TextStyle(fontSize: 15.0,),),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  ),
                ),
              ],
            ),
          );
        else {
          preferencias = model.userData["preferencias"];
            return Container(
              color: Color(0xFFffffff),
              child: _widget,
            );
          }
      }),
    );
  }

  Widget _buildList(eventos) {
    return ListView.separated(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      itemCount: eventos.length+1,
      itemBuilder: (context, index) {
        if (index < eventos.length) {
          return InkWell(
            child: Container(
              height: 132.0,
              decoration: BoxDecoration(
                  color: Color(0xFFAED6F1),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0,3),
                    )
                  ]
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      eventos[index].imagem,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  Flexible(
                    child: Text(eventos[index].nome + "...",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),),
                  ),
                  SizedBox(width: 8.0,),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      EventScreen(evento: eventos[index],)));
            },
          );
        }
        else {
          return InkWell(
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Color(0xFF3498DB),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Center(
                child: Text("Carregar mais",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),),
              ),
            ),
            onTap: start < 80 ? () {
                start += 10;
                /*_scrollController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                _getEvents(preferencias).then((value) {
                  setState(() {
                    _widget = _buildList(value);
                  });
                });*/
                _getEvents(preferencias).then((value) {
                  setState(() {
                    _widget = _buildList(value);
                  });
                });
            } : null,
          );
        }
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 16,);
      },
    );
  }

  Future<List<Event>> _getEvents(List<dynamic> value) async {

    for (dynamic d in value) {
      log(d.toString());
      String url = "https://www.googleapis.com/customsearch/v1?key=AIzaSyAtnNh2AekKMAHXWvufJeMcKKjBtqrqIKw&cx=015647702173191900121:rnlapfdp6zo&q=evento+${d.toString()}+campinas&linkSite&start=${start}&sort=date";
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        log("ok");
        List<Event> eventosUmTipo = [];
        Map<String, dynamic> mapa = jsonDecode(response.body);

        for (int i = 0; i < mapa["items"].length; i++) {
          if (mapa["items"][i]["pagemap"]["metatags"][0]["og:title"].length >
                  50 &&
              mapa["items"][i]["pagemap"]["metatags"][0]["og:description"]
                      .length >
                  50) {
            eventosUmTipo.add(new Event(
                mapa["items"][i]["pagemap"]["metatags"][0]["og:title"],
                mapa["items"][i]["pagemap"]["metatags"][0]["og:description"],
                mapa["items"][i]["pagemap"]["metatags"][0]["og:url"],
                mapa["items"][i]["pagemap"]["metatags"][0]["og:image"],
                null));
          }
        }

        if (eventosUmTipo.length <= 3) {
          for (int i = 0; i < eventosUmTipo.length; i++) {
            allEvents.add(eventosUmTipo[i]);
          }
        } else {
          bool diferente;
          for (int i = 0; i < 3; i++) {
            diferente = true;

            if (eventosUmTipo[i].nome.substring(0, 4) != "https") {
              for(int j = 0; j < allEvents.length; j++) {
                if (eventosUmTipo[i].nome == allEvents[j].nome)
                  diferente = false;
              }
              if (diferente)
                allEvents.add(eventosUmTipo[i]);
            }
          }
        } // else
      }
      else { log(response.statusCode.toString()); }
    } // for event
    return allEvents;
  }
}
