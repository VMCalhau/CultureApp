import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                const Color.fromARGB(255, 27, 94, 32),
                const Color.fromARGB(255, 255, 235, 59),
                const Color.fromARGB(255, 40, 53, 147),
              ])),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 64.0),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(32.0),
                children: <Widget>[
                  Center(
                    child: Text("Entrar",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) return "Email inválido";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Senha"),
                    validator: (text) {
                      if (text.isEmpty || text.length < 8) return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){},
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400
                        ),),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 32.0,),
                  SizedBox(
                    height: 48.0,
                    child: RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: (){
                        if (_formKey.currentState.validate()) {

                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0,),
                  Center(
                    child: Text("- OU -",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 32.0,),
                  SizedBox(
                    height: 38.0,
                    child: SignInButton(
                      Buttons.Facebook,
                      text: "Entrar com o Facebook",
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)
                      ),
                    ),
                  )
                ],
              ),
            )
          )),
    );
  }
}
