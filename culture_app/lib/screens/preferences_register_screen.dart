import 'package:culture_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PreferencesRegisterScreen extends StatefulWidget {
  @override
  _PreferencesRegisterScreenState createState() =>
      _PreferencesRegisterScreenState();
}

class _PreferencesRegisterScreenState extends State<PreferencesRegisterScreen> {

  List _preferencesList = [];
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
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
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Preferências",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      itemCount: _preferencesList.length,
                      itemBuilder: (context, index) {
                          return card(index);
                      }),
                )
              ],
            ),
          )
        )
      );
    }));
  }

  Widget card(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_preferencesList[index]["ok"])
            _preferencesList[index]["ok"] = false;
          else
            _preferencesList[index]["ok"] = true;
        });
      },
      child: Container(
        height: 52,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
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
      )
    );
  }
}
