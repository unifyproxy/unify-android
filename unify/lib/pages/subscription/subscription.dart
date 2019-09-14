import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unify/bloc/subscription.dart';
import 'package:unify/global.dart';

import 'new_sub.dart';

class SubscriptionPage extends StatefulWidget {
  static const ID = "SubscriptionPage";
  final SubscriptionBloc _subscriptionBloc;

  SubscriptionPage(this._subscriptionBloc);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<TextEditingController> _nameControllers = List();
  List<TextEditingController> _urlControllers = List();
  List<bool> _enable = List();

  @override
  void initState() {
    super.initState();

    widget._subscriptionBloc.subs.listen((subs) {
      setState(() {
        _nameControllers = List(subs.length);
        _urlControllers = List(subs.length);
        _enable = List(subs.length);
        for (var i = 0; i < subs.length; i++) {
          _nameControllers[i] = TextEditingController();
          _nameControllers[i].text = subs[i].name;
          _urlControllers[i] = TextEditingController();
          _urlControllers[i].text = subs[i].url;
          _enable[i] = subs[i].enabled;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("fab pressed");
            // widget._subscriptionBloc
            //     .addSub(Subscription("https://foo.bar/${Random().nextInt(20)}"));

            // TODO: need add a temporary item
            showDialog(
              context: context,
              builder: (_) => NewSubForm(widget._subscriptionBloc),
            );
          },
        ),
      ),
      body: Builder(
        builder: (context) => ListView.builder(
          itemCount: _urlControllers.length,
          itemBuilder: (_, index) => buildSubList(
              _nameControllers[index], _urlControllers[index], _enable[index]),
        ),
      ),
    );
  }

  submit(Subscription sub) {
    var a;
    var a;
    if (sub != null) {
      return widget._subscriptionBloc.addSub(sub);
    }
    return false;
  }

  Widget buildSubList(TextEditingController nameController,
      TextEditingController urlController, bool enable) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection dismissDirection) {
        widget._subscriptionBloc.removeSub(
            Subscription(urlController.text, name: nameController.text));
      },
      child: Padding(
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
                      if (submit(Subscription(
                        urlController.text,
                        name: nameController.text,
                      ))) {
                        // reset();
                        return;
                      }
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("invalid sub url")));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
