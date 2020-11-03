import 'package:culture_app/models/User.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/preferences_register_screen.dart';
import 'package:culture_app/services/via_cep_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';


class DataRegisterScreen extends StatelessWidget {
  final User user;
  DataRegisterScreen({Key key, @required this.user}) : super(key: key);

  /*@override
  _DataRegisterScreenState createState() => _DataRegisterScreenState();*/

  final _formKey = GlobalKey<FormState>();
  final _idadeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();

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
                            child: Text("Dados Pessoais",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            controller: _idadeController,
                            decoration: InputDecoration(
                                hintText: "Idade"),
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text.isEmpty) return "Idade inválida";
                            },
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            controller: _enderecoController,
                            decoration: InputDecoration(
                                hintText: "CEP (Somente dígitos)",
                                suffixIcon: IconButton(
                                  onPressed: _consultaCep,
                                  icon: Icon(Icons.arrow_forward),
                                )),
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            validator: (text) {
                              if (text.length != 8) return "CEP inválido";
                              else if (_ruaController.text == "") return "Valide o CEP";
                            },
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            controller: _ruaController,
                            decoration: InputDecoration(
                                hintText: "Rua"),
                            enabled: false,
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            controller: _bairroController,
                            decoration: InputDecoration(
                                hintText: "Bairro"),
                            enabled: false,
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            controller: _cidadeController,
                            decoration: InputDecoration(
                                hintText: "Cidade"),
                            enabled: false,
                          ),
                          SizedBox(height: 32.0,),
                          SizedBox(
                            height: 48,
                            child: RaisedButton(
                              child: Text("Continuar",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              textColor: Colors.white,
                              color: Colors.black,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  user.idade = int.parse(_idadeController.text);
                                  user.cep = _enderecoController.text;

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PreferencesRegisterScreen(user: user)));

                                }


                                /*if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> userData = {
                                    "idade": _idadeController.text,
                                    "cep": _enderecoController.text,
                                  };
                                  Future.delayed(Duration(seconds: 2)).then((
                                      _) {
                                    //Navigator.of(context).pop();
                                    //Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreferencesRegisterScreen()));
                                  });
                                }*/
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
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>
                                            LoginScreen()));
                                  },
                                  child: Text(
                                    'Entrar',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blueAccent,
                                        fontSize: 16
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ))
    );
  }

  Future _consultaCep () async {
    final cep = _enderecoController.text;
    final resultCep = await ViaCepService.fetchCep(cep: cep);

    _ruaController.text = resultCep.logradouro;
    _bairroController.text = resultCep.bairro;
    _cidadeController.text = resultCep.localidade;
  }

}

/*class _DataRegisterScreenState extends State<DataRegisterScreen> {
  final User user;
  _DataRegisterScreenState({Key key, @required this.user});


}*/
