import 'package:flutter/material.dart';

Drawer myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.amberAccent,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Tap Here To SignIn',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
