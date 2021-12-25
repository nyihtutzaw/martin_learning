import 'package:flutter/material.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/providers/auth_provider.dart';
import 'package:optimize/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: activeColors.primary,
          title: Text("   Manage Profile"),
          centerTitle: false,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawer: const MyDrawer(),
        body: Container(
            child: Column(
          children: <Widget>[
            Consumer<Auth>(builder: (context, authStatte, child) {
              return Container(
                  decoration: BoxDecoration(
                    color: activeColors.primary,
                  ),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.person,
                          color: activeColors.white,
                          size: 100,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Mg Mg",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'mgmg@gmail.com',
                            style: TextStyle(
                                fontSize: 18, color: activeColors.white),
                          ),
                        ],
                      )
                    ],
                  ));
            }),
            Expanded(
              child: ListView(children: <Widget>[
                InkWell(
                  onTap: () {
                    //Navigator.of(context).pushNamed(FontChangeScreen.routeName);
                  },
                  child: Card(
                      child: ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Change Password"),
                  )),
                ),
              ]),
            )
          ],
        )));
  }
}
