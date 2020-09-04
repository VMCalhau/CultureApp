import 'package:culture_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterScreen extends StatelessWidget {
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
                      child: Text("Cadastrar",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Nome"),
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

                    SizedBox(height: 32.0,),
                    SizedBox(
                      height: 48,
                      child: RaisedButton(
                        child: Text("Cadastrar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.black,
                        onPressed: (){
                          if (_formKey.currentState.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.0,),
                    //Divider(color:  Colors.black),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Já possui uma conta? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                  decoration: TextDecoration.underline, color: Colors.blue, fontSize: 16
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )),
    );
  }
}
