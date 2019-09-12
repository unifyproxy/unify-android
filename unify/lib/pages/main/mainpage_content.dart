import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unify/pages/main/proxy_listview.dart';
import 'package:provider/provider.dart';
import 'package:unify/pages/main/states/bottom_bar.dart';
import 'bottombar.dart';

class MainPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<MainPageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: ChangeNotifierProvider<BottomBarState>(
          builder: (_) => BottomBarState(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ProxyListView(),
              ),
              FloatingActionButton(
                tooltip: "Connect to selected server",
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () => null,
                child: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white30,
                ),
              ),
              SizedBox(
                height: 50,
                child: Consumer(builder: (_, bottombarState, __) => BottomAppBar(),),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }
}
