import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unify/pages/main/bottombar.dart';
import 'package:unify/pages/main/proxy_listview.dart';
import 'package:provider/provider.dart';
import 'package:unify/pages/main/states/bottombar_state.dart';

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
                child: Consumer<BottomBarState>(
                    builder: (_, bottombarState, __) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              ProxyListView(bottombarState),
                              Positioned(
                                child: FloatingActionButton(
                                  tooltip: "Connect to selected server",
                                  onPressed: () => null,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
              ),
              SizedBox(
                height: 50,
                child: Consumer<BottomBarState>(
                  builder: (_, bottombarState, __) => BottomBar(bottombarState),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }
}
