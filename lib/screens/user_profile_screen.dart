import 'package:flutter/material.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/providers/auth_provider.dart';
import 'package:optimize/screens/change_password_screen.dart';
import 'package:optimize/screens/update_profile_screen.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });

    await Provider.of<Auth>(context, listen: false).getUser();

    setState(() {
      _isPreloading = false;
    });
  }

  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

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
        body: _isPreloading
            ? FullScreenPreloader()
            : Container(
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
                                  authStatte.currentUser.username,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  authStatte.currentUser.email,
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
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Subscribed Course"),
                      ),
                      Card(child: ListTile(title: Text("Road So Far (Book)"))),
                      Card(child: ListTile(title: Text("PN Title (Book)"))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                        child: Card(
                            child: ListTile(
                          leading: Icon(Icons.lock),
                          title: Text("Change Password"),
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(),
                            ),
                          );
                        },
                        child: Card(
                            child: ListTile(
                          leading: Icon(Icons.account_box),
                          title: Text("Update Profile"),
                        )),
                      ),
                    ]),
                  )
                ],
              )));
  }
}
