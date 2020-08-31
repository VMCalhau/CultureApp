import 'dart:async';
import 'package:culture_app/blocs/drawer_bloc.dart';
import 'package:culture_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController _pageController = PageController();
  DrawerBloc _drawerBloc;
  StreamSubscription _drawerSubscription;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DrawerBloc drawerBloc = Provider.of<DrawerBloc>(context);
    if(drawerBloc != _drawerBloc){
      _drawerBloc = drawerBloc;
      _drawerSubscription?.cancel();
      _drawerSubscription = _drawerBloc.outPage.listen((page) {
        _pageController.jumpToPage(page);
      });
    }
  }


  @override
  void dispose() {
    _drawerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          Container(color: Colors.yellow,),
          Container(color: Colors.blue,),
          Container(color: Colors.yellow,),
        ],
      ),
    );
  }
}
