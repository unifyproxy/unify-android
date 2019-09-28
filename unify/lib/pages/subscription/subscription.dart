import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/bloc/proxy_list.dart';
import 'package:unify/global.dart';

import 'new_sub.dart';

class SubscriptionPage extends StatefulWidget {
  static const ID = "SubscriptionPage";

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<TextEditingController> _nameControllers = List();
  List<TextEditingController> _urlControllers = List();
  List<bool> _enable = List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final subs = Provider.of<SubscriptionBloc>(context).subs;
    // final proxys = Provider.of<ProxyListBloc>(context);

    if (!mounted) return;
    setState(() {
      _nameControllers = List(subs.length);
      _urlControllers = List(subs.length);
      _enable = List(subs.length);
      for (var i = 0; i < subs.length; i++) {
        final sub = subs[i];

        _nameControllers[i] = TextEditingController();
        _nameControllers[i].text = sub.name;
        _urlControllers[i] = TextEditingController();
        _urlControllers[i].text = sub.url;
        _enable[i] = sub.enabled;

        // for (var node in sub.nodes) {
        //   if (node.type == ProxyType.SSR) {
        //     proxys.addSSRServer(node.node);
        //   } else if (node.type == ProxyType.V2ray) {
        //     proxys.addV2rayServer(node.node);
        //   }
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionBloc>(builder: (context, subscriptionBloc, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => NewSubForm(subscriptionBloc),
              );
            },
          ),
        ),
        body: Builder(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              await subscriptionBloc.updateSubs();
              return Future(() {
                final subs = Provider.of<SubscriptionBloc>(context);
                final pList = Provider.of<ProxyListBloc>(context);

                subs
                    .updateSubs()
                    .then((_pList) => _pList.forEach((p) => pList.addProxy(p)));
                // subs.forEach((sub) {
                //   // add proxy to Proxy_list;
                //   if (sub.enabled) {
                //     for (var node in sub.nodes) {
                //       pList.addProxy(node);
                //     }
                //   }
                // });
              });
            },
            child: ListView.builder(
              itemCount: subscriptionBloc.subs.length,
              itemBuilder: (_, index) => buildSubList(
                index,
                subscriptionBloc,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildSubList(
    int index,
    SubscriptionBloc subscriptionBloc,
  ) {
    TextEditingController nameController = _nameControllers[index];
    TextEditingController urlController = _urlControllers[index];
    bool enable = _enable[index];
    final id = subscriptionBloc.subs[index].id;

    return Dismissible(
      key: ValueKey(subscriptionBloc.subs[index].id),
      onDismissed: (DismissDirection dismissDirection) {
        subscriptionBloc.removeSub(id);
      },
      child: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 50, child: Text("Name: ")),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                      ),
                    ),
                    Checkbox(
                      value: enable,
                      onChanged: (bool checked) {
                        setState(() {
                          enable = checked;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 50, child: Text("URL: ")),
                    Expanded(
                      child: TextField(
                        controller: urlController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        subscriptionBloc.change(
                          id,
                          name: nameController.text,
                          url: urlController.text,
                        );

                        final pList = Provider.of<ProxyListBloc>(context);
                        pList.changeSubName(id, nameController.text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
