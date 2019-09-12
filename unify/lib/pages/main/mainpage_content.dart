import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/global.dart';
import 'package:unify/pages/main/bottombar.dart';
import 'package:unify/pages/main/proxy_listview.dart';
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer2<BottomBarState, ProxyListBloc>(
                  builder: (context, bottombarState, proxyListBloc, __) =>
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            ProxyListView(bottombarState, proxyListBloc),
                            Positioned(
                              child: FloatingActionButton(
                                tooltip: "Connect to selected server",
                                backgroundColor:
                                    Provider.of<BottomBarState>(context)
                                                .curType ==
                                            BottomBarStateEnum.V2RAY
                                        ? GlobalTheme.v2rayTheme.accentColor
                                        : GlobalTheme.ssrTheme.accentColor,
                                onPressed: () {},
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white60,
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
    );
  }
}
