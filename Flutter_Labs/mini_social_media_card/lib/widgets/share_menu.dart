import 'package:flutter/material.dart';

void showShareOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => ListView(
      shrinkWrap: true,
      children: const [
        ListTile(leading: Icon(Icons.link), title: Text("Copy Link")),
        ListTile(
          leading: Icon(Icons.facebook),
          title: Text("Share to Facebook"),
        ),
        ListTile(leading: Icon(Icons.share), title: Text("Other Options")),
      ],
    ),
  );
}
