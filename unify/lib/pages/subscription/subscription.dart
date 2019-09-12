import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/global.dart';

class SubscriptionPage extends StatefulWidget {
  static const ID = "SubscriptionPage";
  final SubscriptionBloc _subscriptionBloc;

  SubscriptionPage(this._subscriptionBloc);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("fab pressed");
          widget._subscriptionBloc.addSub(Subscription("https://foo.bar"));
        },
      ),
      body: StreamBuilder(
        stream: widget._subscriptionBloc.subs,
        builder: (_, AsyncSnapshot<List<Subscription>> snap) => ListView(
          children: snap.hasData ? snap.data.map((buildSubList)).toList() : [],
        ),
      ),
    );
  }

  Widget buildSubList(Subscription sub) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 50, child: Text("Name: ")),
                Text(sub.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 50, child: Text("URL: ")),
                Text(sub.url),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
