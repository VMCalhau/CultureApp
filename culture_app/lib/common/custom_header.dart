import 'package:culture_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ // clicar em toda a area do header
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginScreen())
        );
      },
      child: Container(
        height: 115,
        padding: EdgeInsets.only(left: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepOrange,
                Colors.orangeAccent
              ]),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.person, color: Colors.white, size: 30,),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Acesse sua conta!",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.clip,
                  ),
                  Text("Clique aqui",
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.clip,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
