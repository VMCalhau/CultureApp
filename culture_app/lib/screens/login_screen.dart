import 'package:culture_app/models/User.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/account_register_screen.dart';
import 'package:culture_app/screens/register_screen.dart';
import 'package:culture_app/screens/stepper_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = new User(null, null, null, null, null, null);

    final _emailController = TextEditingController();
    final _senhaController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Container(
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
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text.isEmpty || !text.contains("@")) return "Email inválido";
                          },
                        ),
                        SizedBox(height: 16.0,),
                        TextFormField(
                          controller: _senhaController,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
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
                                model.signIn(
                                    email: _emailController.text,
                                    senha: _senhaController.text,
                                    onSuccess: _onSuccess, onFail: _onFail);
                              }

                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      HomeScreen()));

                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        /*SizedBox(height: 32.0,),
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
                        ),*/
                        SizedBox(height: 32.0,),
                        Divider(color:  Colors.black,),
                        SizedBox(height: 32.0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Não tem uma conta? ',
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountRegisterScreen(user: user,)));
                                },
                                child: Text(
                                  'Cadastre - se',
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
                  ),
              ),
          );
        },
      )


    );
  }

  void _onSuccess(){
    print("sucess");
  }
  void _onFail(){
    print("failed");
  }

}
