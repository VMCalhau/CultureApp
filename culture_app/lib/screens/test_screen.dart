import 'package:culture_app/models/Event.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  List<Event> ee = [new Event("Lagoa do Taquaral terá várias atividades na “Manhã de Combate ao Sedentarismo” no domingo, 22", null, null, "https://campinas.com.br/wp-content/uploads/2018/12/lagoadotaquaral-veraovivo.jpg", null)];

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Color(0xFFffffff),
        padding: EdgeInsets.only(top: 64),
        child: _buildList(ee),
      ),
    );
  }

  Widget _buildList(eventos) {
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
  }
}

