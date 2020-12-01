import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_app/models/Event.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  Widget _widget = Center(child: CircularProgressIndicator(),);

  List<Event> eventos = [];

  void buscar(context) {
    Future.delayed(Duration(seconds: 3), (){
      setState(() {
        _widget = _buildList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => buscar(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos Favoritos"),
      ),
      body: ScopedModelDescendant<UserModel> (builder: (context, child, model) {
        if (model.isLoading) return Center(child: CircularProgressIndicator(),);
        if (!model.isLogged()) {
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ),
              ],
            ),
          );
        }
        Firestore.instance.collection("users").document(model.firebaseUser.uid).collection("favorites").getDocuments().then((value) {
          value.documents.forEach((e) {
              eventos.add(new Event(e.data["nome"], e.data["descricao"], e.data["url"], e.data["imagem"], null));
          });
        });
        return _widget;
      },),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      itemCount: eventos.length,
      itemBuilder: (context, index) {
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
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 16,);
      },
    );
  }

}
