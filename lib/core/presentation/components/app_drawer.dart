import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              child: Material(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:10),
                child: ListTile(
                  title: Text('List Item 1'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text('List Item 2'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text('List Item 3'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
