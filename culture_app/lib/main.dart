import 'package:culture_app/blocs/drawer_bloc.dart';
import 'package:culture_app/models/user_model.dart';
import 'package:culture_app/screens/account_register_screen.dart';
import 'package:culture_app/screens/home_screen.dart';
import 'package:culture_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MultiProvider(
        providers: [
          Provider<DrawerBloc>(
            create: (_) => DrawerBloc(),
            dispose: (context, value) => value.dispose(),
          )
        ],
        child: MaterialApp(
          title: 'Culture APP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
