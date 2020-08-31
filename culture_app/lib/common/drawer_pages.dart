import 'package:culture_app/blocs/drawer_bloc.dart';
import 'package:culture_app/common/icon_pages.dart';
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
              label: "Inicio",
              iconData: Icons.home,
              onTap: (){
                _setPage(0);
              },
              highlighted: snapshot.data == 0,
            ),
            IconPages(
              label: "Favoritos",
              iconData: Icons.favorite,
              onTap: (){
                _setPage(1);
              },
              highlighted: snapshot.data == 1,
            ),

            IconPages(
              label: "Editar Perfil",
              iconData: Icons.edit,
              onTap: (){
                _setPage(2);
              },
              highlighted: snapshot.data == 2,
            )
          ],
        );
      },
    );
  }
}
