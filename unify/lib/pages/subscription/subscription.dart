import 'package:flutter/material.dart';
import 'package:unify/bloc/subscription.dart';

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
    return Container();
  }
}
