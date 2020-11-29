import 'package:culture_app/models/Event.dart';
import 'package:culture_app/screens/event_screen.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  //List<Event> ee = [new Event("Lagoa do Taquaral terá várias atividades na “Manhã de Combate ao Sedentarismo” no domingo, 22", null, null, "https://campinas.com.br/wp-content/uploads/2018/12/lagoadotaquaral-veraovivo.jpg", null)];

  @override
  Widget build(BuildContext context) {
    /*return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Color(0xFFffffff),
        padding: EdgeInsets.only(top: 64),
        child: _buildList(ee),
      ),
    );*/
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    EventScreen(evento: new Event("Lagoa do Taquaral terá várias atividades na “Manhã de Combate ao Sedentarismo” no domingo, 22", "Organizado pela Secretaria Municipal de Esportes e Lazer, a Lagoa do Taquaral (portal 7) recebe, neste domingo (22), às 9h, a", "https://campinas.com.br/agenda/lagoa-do-taquaral-tera-varias-atividades-na-manha-de-combate-ao-sedentarismo-no-domingo-22/", "https://campinas.com.br/wp-content/uploads/2018/12/lagoadotaquaral-veraovivo.jpg", null),)));
          },
        ),
      ),
    );
  }

  /*Widget _buildList(eventos) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return Container(
          height: 88.0,
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
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 16,);
      },
    );
  }*/
}

