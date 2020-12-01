import 'package:culture_app/models/User.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/services/via_cep_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  User user;
  TextStyle _myStyle2(){
    return TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold
    );
  }
  FocusNode myFocus;
  @override
  void initState() {
    super.initState();
    myFocus = new FocusNode();
  }
  @override
  Widget build(BuildContext context) {
    final _ruaController = TextEditingController();
    final _bairroController = TextEditingController();
    final _cidadeController = TextEditingController();
    final _emailController = TextEditingController();
    final _enderecoController = TextEditingController();
    final _preferenciasController = TextEditingController();



    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        Future _consultaCep () async {
          final cep = _enderecoController.text;
          final resultCep = await ViaCepService.fetchCep(cep: cep);
          print(cep);
          _ruaController.text = resultCep.logradouro;
          _bairroController.text = resultCep.bairro;
          _cidadeController.text = resultCep.localidade;
        }
        return Scaffold(
          backgroundColor: Color(0xffF8F8FA),
          body: SingleChildScrollView(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade500,
                          Colors.blue
                        ]),
                  ),
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.only(left: 50, right: 30, top: 30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Meu Perfil", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                ),),
                                /*SizedBox(height: 10,),
                                Text("Perfil", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),*/
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 175),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 120, left: 50),
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 10,
                            offset: Offset(0,0),
                          )
                        ]
                    ),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 110),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(top: 300, left: 50),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home),
                      SizedBox(width: 10,),
                      Text("Endereço", style: _myStyle2(),),
                      SizedBox(width: 70,),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(width: 10,),
                            Text("Pesquisar", style: _myStyle2(),)
                          ],
                        ),
                        onTap: (){
                          if(_enderecoController.text == "")
                            "Digite o seu CEP corretamente";
                          else
                            _consultaCep();
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 330, left: 30),
                  child: Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red,
                              blurRadius: 10,
                              offset: Offset(0,0),
                            )
                          ]
                      ),
                      child: Form(
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              controller: _enderecoController,
                              decoration: InputDecoration(
                                hintText: "CEP",),
                              keyboardType: TextInputType.number,
                              maxLength: 8,
                              validator: (text) {
                                if (text.length != 8) return "CEP inválido";
                                else if (_ruaController.text == "") return "Valide o CEP";
                              },
                            ),
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
                          ],
                        ),
                      )
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.only(top: 555, left: 50),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      SizedBox(width: 10,),
                      Text("E-mail", style: _myStyle2(),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(top: 580, left: 50),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 10,
                            offset: Offset(0,0),
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: TextField(
                        controller: _emailController,

                        decoration: InputDecoration(hintText: model.userData["email"].toString()),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 650, left: 50),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.bookmark),
                      SizedBox(width: 10,),
                      Text("Preferenências", style: _myStyle2(),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(top: 680, left: 50),
                  child: Container(
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 10,
                            offset: Offset(0,0),
                          )
                        ]
                    ),
                    child: TextFormField(
                      focusNode: myFocus,
                      controller: _preferenciasController,
                      decoration: InputDecoration(labelText: model.userData["preferencias"].toString()),
                      enabled: false,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 900, left: 340),
                  child: FlatButton(
                    shape: CircleBorder(),
                    color: Colors.blue,
                    child: InkWell(
                      splashColor: Colors.red,
                      child: SizedBox(width: 56, height: 56, child: Icon(Icons.edit),),
                    ),
                    onPressed: (){

                    },
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        );
      },
    );

  }

  void _onSuccess(){
    print("success");
  }
  void _onFail(){
    print("failed");
  }

}