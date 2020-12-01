import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/home_screen.dart';
import 'package:culture_app/services/via_cep_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _enderecoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List _preferencesList = [];

  bool mudouCep = false;

  TextStyle _myStyle2(){
    return TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold
    );
  }

  void addList(String title) {
    setState(() {
      Map<String, dynamic> newTile = Map();
      newTile["title"] = title;
      newTile["ok"] = false;
      _preferencesList.add(newTile);
    });
  }

  Future _consultaCep (String cep) async {
    final resultCep = await ViaCepService.fetchCep(cep: cep);
    mudouCep = true;
    _ruaController.text = resultCep.logradouro;
    _bairroController.text = resultCep.bairro;
    _cidadeController.text = resultCep.localidade;
  }

  @override
  void initState() {
    addList("Cinema");
    addList("Crianças");
    addList("Esportes");
    addList("Games/Geek");
    addList("Gastronomia");
    addList("Museus");
    addList("Música");
    addList("Turismo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel> (builder: (context, child, model) {
      if (model.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      if (!model.isLogged()) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Editar Perfil"),
          ),
          body: Center(
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
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Editar Perfil"),
        ),
        backgroundColor: Color(0xffF8F8FA),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0,0),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("imagens/person.png")
                                  )
                              ),
                            ),
                            Text(model.userData["nome"].toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                            Text(model.userData["idade"].toString() + " anos" , style: _myStyle2(),)
                          ],
                        ),
                      )
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(width: 10,),
                    Text("Endereço", style: _myStyle2()),
                    SizedBox(width: 70,),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        color: Color(0XFF85C1E9),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(width: 10,),
                            Text("Pesquisar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)
                          ],
                        ),
                      ),
                      onTap: (){
                        if(_enderecoController.text == "")
                          "Digite o seu CEP corretamente";
                        else
                          _consultaCep(_enderecoController.text);
                      },
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0,0),
                          )
                        ]
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                            child: TextFormField(
                              controller: _enderecoController,
                              decoration: InputDecoration(
                                hintText: "Alterar CEP",),
                              keyboardType: TextInputType.number,
                              maxLength: 8,
                              validator: (text) {
                                if (text.length != 8) return "CEP inválido";
                                else if (_ruaController.text == "") return "Valide o CEP";
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                            child: TextFormField(
                              controller: _ruaController,
                              decoration: InputDecoration(
                                  hintText: "Rua"),
                              enabled: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                            child: TextFormField(
                              controller: _bairroController,
                              decoration: InputDecoration(
                                  hintText: "Bairro"),
                              enabled: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                            child: TextFormField(
                              controller: _cidadeController,
                              decoration: InputDecoration(
                                  hintText: "Cidade"),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.only(left: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.bookmark),
                      SizedBox(width: 10,),
                      Text("Preferências", style: _myStyle2(),)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    height: 324.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0,0),
                          )
                        ]
                    ),
                    child: ListView.builder(
                        itemCount: _preferencesList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return card(index);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.edit),
          onPressed: (){
            if (mudouCep) {
              Firestore.instance.collection("users").document(model.firebaseUser.uid).updateData({"cep":_enderecoController.text});

              model.userData["cep"] = _enderecoController.text;
            }

            List<String> finalList = [];

            for (int i = 0; i < _preferencesList.length; i++) {
              if (_preferencesList[i]["ok"]) {
                print(_preferencesList[i]["title"]);
                finalList.add(_preferencesList[i]["title"]);
              }
            }

            if (finalList.length != 0) {
              Firestore.instance.collection("users").document(model.firebaseUser.uid).updateData({"preferencias":finalList});

              model.userData["preferencias"] = finalList;
            }

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    HomeScreen()));
          },
        ),
      );
    },);
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
}
