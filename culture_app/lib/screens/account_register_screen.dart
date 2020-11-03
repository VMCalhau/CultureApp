import 'package:culture_app/models/User.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/home_screen.dart';
import 'package:culture_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data_register_screen.dart';

class AccountRegisterScreen extends StatelessWidget {
  final User user;
  AccountRegisterScreen({Key key, @required this.user}) : super(key: key);

  /*@override
  _AccountRegisterScreenState createState() => _AccountRegisterScreenState(user: user);*/
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senha2Controller = TextEditingController();

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
                        child: Text(
                          "Conta",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(hintText: "Nome"),
                        validator: (text) {
                          if (text.isEmpty) return "Nome inválido";
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text.isEmpty) return "Email inválido";
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _senhaController,
                        decoration: InputDecoration(hintText: "Senha"),
                        keyboardType: TextInputType.multiline,
                        validator: (text) {
                          if (text.isEmpty)
                            return "Senha inválida";
                          else if (text.length < 8)
                            return "Senha muito curta (min 8 caracteres)";
                          else if (text != _senha2Controller.text)
                            return "Senhas precisam ser iguais";
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _senha2Controller,
                        decoration: InputDecoration(hintText: "Repetir senha"),
                        keyboardType: TextInputType.multiline,
                        validator: (text) {
                          if (text != _senhaController.text)
                            return "Senhas precisam ser iguais";
                        },
                      ),

                      SizedBox(
                        height: 32.0,
                      ),
                      SizedBox(
                        height: 48,
                        child: RaisedButton(
                          child: Text(
                            "Continuar",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          textColor: Colors.white,
                          color: Colors.black,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              user.nome = _nameController.text;
                              user.email = _emailController.text;
                              user.senha = _senhaController.text;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DataRegisterScreen(user: user)));
                            }

                            /*if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> userData = {
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                  };
                                  model.signUp(userData: userData,
                                      senha: _senhaController.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail);
                                  Future.delayed(Duration(seconds: 2)).then((
                                      _) {
                                    //Navigator.of(context).pop();
                                    //Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataRegisterScreen()));
                                  });
                                }*/
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blueAccent,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}

/*
class _AccountRegisterScreenState extends State<AccountRegisterScreen> {
  final User user;
  _AccountRegisterScreenState({Key key, @required this.user});
}*/
