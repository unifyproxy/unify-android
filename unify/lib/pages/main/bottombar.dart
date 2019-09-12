import 'package:flutter/material.dart';
import 'package:unify/global.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';

class BottomBar extends StatefulWidget {
  final BottomBarState _bottomBarState;
  BottomBar(this._bottomBarState);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  BottomBarState _bottomBarState;

  @override
  void initState() {
    super.initState();

    _bottomBarState = widget._bottomBarState;
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MyCustomClipper(),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                color: _bottomBarState.curType == BottomBarStateEnum.V2RAY
                    ? GlobalConstent.v2rayTheme.mainColor
                    : GlobalConstent.v2rayTheme.secondaryColor,
                focusColor: Colors.blue[400],
                child: Center(child: Text("V2ray")),
                onPressed: () {
                  setState(() {
                    _bottomBarState.curType = BottomBarStateEnum.V2RAY;
                  });
                },
              ),
            ),
            Expanded(
              child: FlatButton(
                color: _bottomBarState.curType == BottomBarStateEnum.SSR
                    ? GlobalConstent.ssrTheme.mainColor
                    : GlobalConstent.ssrTheme.secondaryColor,
                focusColor: Colors.red[400],
                child: Center(child: Text("SSR")),
                onPressed: () {
                  setState(() {
                    _bottomBarState.curType = BottomBarStateEnum.SSR;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width / 2 - 25, 0);
    path.arcToPoint(
      Offset(size.width / 2 + 25, 0),
      radius: Radius.circular(50),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
