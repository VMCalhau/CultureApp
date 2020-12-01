import 'package:culture_app/blocs/drawer_bloc.dart';
import 'package:culture_app/common/icon_pages.dart';
import 'package:culture_app/screens/edit_profile.dart';
import 'package:culture_app/screens/favorites_screen.dart';
import 'package:culture_app/screens/questionnaire.java.dart';
import 'package:culture_app/screens/update_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class DrawerPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerBloc _drawerBloc = Provider.of<DrawerBloc>(context);

    void _setPage(int page){
      Navigator.of(context).pop();
      _drawerBloc.setPage(page);
    }
    return StreamBuilder<int>(
      stream: _drawerBloc.outPage,
      builder: (context, snapshot){
        return Column(
          children: <Widget>[
            IconPages(
              label: "Eventos",
              iconData: Icons.bookmark,
              onTap: (){
                _setPage(0);
              },
              highlighted: snapshot.data == 0,
            ),
            IconPages(
              label: "Favoritos",
              iconData: Icons.favorite,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesScreen()));
              },
              highlighted: snapshot.data == 1,
            ),
            IconPages(
              label: "Editar Perfil",
              iconData: Icons.edit,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },
              highlighted: snapshot.data == 2,
            ),
            IconPages(
              label: "Questionário",
              iconData: Icons.assignment,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Questionnaire()));
              },
              highlighted: snapshot.data == 3,
            )
          ],
        );
      },
    );
  }
}
