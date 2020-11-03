import 'package:culture_app/models/User.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PreferencesRegisterScreen extends StatefulWidget {
  final User user;
  PreferencesRegisterScreen({Key key, @required this.user}) : super(key: key);

  @override
  _PreferencesRegisterScreenState createState() =>
      _PreferencesRegisterScreenState(user: user);
}

class _PreferencesRegisterScreenState extends State<PreferencesRegisterScreen> {
  final User user;
  _PreferencesRegisterScreenState({Key key, @required this.user});

  List _preferencesList = [];
  List<String> _finalList = [];
  bool _checked = false;

  void addList(String title) {
    setState(() {
      Map<String, dynamic> newTile = Map();
      newTile["title"] = title;
      newTile["ok"] = false;
      _preferencesList.add(newTile);
    });
  }

  @override
  void initState() {
    addList("Rock");
    addList("Museus");
    addList("Esportes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return SizedBox.expand(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        const Color.fromARGB(255, 27, 94, 32),
                        const Color.fromARGB(255, 255, 235, 59),
                        const Color.fromARGB(255, 40, 53, 147),
                      ])),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 48, 32, 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Preferências",
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 16),
                              itemCount: _preferencesList.length,
                              itemBuilder: (context, index) {
                                return card(index);
                              }),
                        ),
                        SizedBox(
                          height: 48.0,
                          child: RaisedButton(
                            child: Text(
                              "Finalizar",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            textColor: Colors.white,
                            color: Colors.black,
                            onPressed: () {
                              _finalList = [];
                              for (int i = 0; i < _preferencesList.length; i++) {
                                if (_preferencesList[i]["ok"])
                                  _finalList.add(_preferencesList[i]["title"]);
                              }

                              if (_finalList.length == 0) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Selecione ao menos uma preferência"),
                                        content: null,
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                user.preferencias = _finalList;
                                Map<String, dynamic> userData = {
                                  "nome": user.nome,
                                  "email": user.email,
                                  "idade": user.idade,
                                  "cep": user.cep,
                                  "preferencias": user.preferencias
                                };

                                model.signUp(
                                    userData: userData,
                                    senha: user.senha,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
      }));
  }

  Widget card(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_preferencesList[index]["ok"])
              _preferencesList[index]["ok"] = false;
            else {
              _preferencesList[index]["ok"] = true;
            }
          });
        },
        child: Container(
          height: 52,
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: _preferencesList[index]["ok"],
                onChanged: (value) {
                  setState(() {
                    _preferencesList[index]["ok"] = value;
                  });
                },
              ),
              Text(_preferencesList[index]["title"])
            ],
          ),
        ));
  }

  void _onSuccess(){
    /*Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("Usuário criado"), backgroundColor: Theme.of(context).primaryColor, duration: Duration(seconds: 2),)
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });*/
  }
  void _onFail(){
    /*Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao criar suário"), backgroundColor: Colors.red, duration: Duration(seconds: 2),)
    );*/
  }

}
