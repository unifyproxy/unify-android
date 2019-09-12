import 'package:unify/bloc/subscription.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test subscription obj", () {
    final sub = Subscription("hello");

    assert(sub.name == "untitled");

    assert(sub.url == "hello");
  });

  test("add sub to bloc", () {
    final sub = Subscription("hello");
    final sub2 = Subscription("https://hello.word/");
    final bloc = SubscriptionBloc();
    assert(bloc.addSub(sub) == false);
    assert(bloc.addSub(sub2) == true);
    assert(bloc.subs.length == 1);
  });

  test("test sub url", () async {
    final bloc = SubscriptionBloc();
    assert(await bloc.testSub("https://baidu.com") == true);
  });

  test("parse subs data", () async {
    final f = Directory.current;
    final secret = jsonDecode(File("./secret.json").readAsStringSync());
    final sub = Subscription(secret['v2ray_sub']);
    await sub.update();
  });
}
