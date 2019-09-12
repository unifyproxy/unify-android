import 'package:flutter/material.dart';

import 'package:clippy_flutter/diagonal.dart';

AppBar getMainAppBar() {
  return AppBar(
    title: Text("Unify"),
    leading: Builder(builder: (BuildContext context) {
      return Diagonal(
        child: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: "Menu",
          color: Colors.yellow,
          onPressed: () {
            // open drawer
            var sfd = Scaffold.of(context);
            sfd.openDrawer();

            Scaffold.of(context).showSnackBar(SnackBar(
              content: Container(
                child: Row(
                  children: <Widget>[
                    Text("Menu Clicked"),
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Scaffold.of(context).removeCurrentSnackBar();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              elevation: 20,
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ));
          },
        ),
        clipHeight: 10,
        axis: Axis.vertical,
        position: DiagonalPosition.TOP_RIGHT,
        clipShadows: [ClipShadow(color: Colors.black, elevation: 0)],
      );
    }),
    actions: <Widget>[
      PopupMenuButton(
        icon: Icon(
          Icons.playlist_add,
        ),
        itemBuilder: (_) {
          return ["hello", "world"]
              .map((t) => PopupMenuItem(
                    child: Text(t),
                    value: t,
                  ))
              .toList();
        },
        onSelected: (s) => print(s),
      ),
    ],
  );
}
