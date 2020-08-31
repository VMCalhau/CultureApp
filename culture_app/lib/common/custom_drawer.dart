import 'package:flutter/material.dart';

import 'custom_header.dart';
import 'drawer_pages.dart';
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomHeader(),
          DrawerPages(),
          Divider(color:  Colors.green[500],)
        ],
      ),
    );
  }
}
