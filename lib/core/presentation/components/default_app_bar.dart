import 'package:flutter/material.dart';

AppBar defaultAppBar({Widget title = const Text('Koality Flutter')}) => AppBar(
      title: title,
      bottom: const PreferredSize(
        preferredSize: Size(double.maxFinite, 50),
        child: SizedBox.shrink(),
      ),
    );
