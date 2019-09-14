import 'package:flutter/material.dart';
import 'package:unify/bloc/subscription.dart';

class NewSubForm extends StatefulWidget {
  final SubscriptionBloc _subscriptionBloc;
  NewSubForm(this._subscriptionBloc);
  @override
  _NewSubFormState createState() => _NewSubFormState();
}

class _NewSubFormState extends State<NewSubForm> {
  TextEditingController _newSubNameController = TextEditingController();
  TextEditingController _newSubUrlController = TextEditingController();

  String newSubInfo = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Subscription"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 50,
                  child: Text(
                    "Name: ",
                  )),
              Expanded(
                  child: TextField(
                controller: _newSubNameController,
              )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(width: 50, child: Text("Url: ")),
              Expanded(
                  child: TextField(
                controller: _newSubUrlController,
              )),
            ],
          ),
          Text(
            newSubInfo,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Clear"),
          onPressed: () {
            _newSubNameController.clear();
            _newSubUrlController.clear();
            setState(() {
              newSubInfo = "";
            });
          },
        ),
        FlatButton(
          child: Text("Add"),
          onPressed: () {
            final name = _newSubNameController.text;
            final url = _newSubUrlController.text;
            var result = false;

            if (name == '') {
              result = widget._subscriptionBloc.addSub(Subscription(url));
            } else {
              result = widget._subscriptionBloc
                  .addSub(Subscription(url, name: name));
            }
            if (result) {
              Navigator.of(context).pop();
            } else {
              setState(() {
                newSubInfo = "Invalid input";
              });
            }
          },
        ),
      ],
    );
  }
}
