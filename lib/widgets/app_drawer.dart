import 'package:char_yaar_trade/screens/Add_New_Weight_info.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Welcome To Weight App!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Your Weight'),
            onTap: () {
              Navigator.of(context).pushNamed(NewWeightInfo.routeName);
            },
          )
        ],
      ),
    );
  }
}
