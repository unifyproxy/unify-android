import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:unify/bloc/proxy_info.dart';
import 'package:unify/bloc/subscription.dart';

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
  });

  test("test sub url", () async {
    final bloc = SubscriptionBloc();
    assert(await bloc.testSub("https://baidu.com") == true);
  });

  test("parse v2ray subs data", () async {
    final secret = jsonDecode(File("./secret.json").readAsStringSync());
    final sub = Subscription(secret['v2ray_sub']);
    await sub.update();
  });

  test("parse ssr url", () {
    final content =
        "aGVsbG8uZm9vOjA6YXV0aF9hZXMxMjhfc2hhMTpjaGFjaGEyMC1pZXRmOmh0dHBfc2ltcGxlOmVtTnpjM0l1WTI5dC8/b2Jmc3BhcmFtPU1qQTFNek00TURRM09TNXRhV055YjNOdlpuUXVZMjl0JnByb3RvcGFyYW09T0RBME56azZhWEJ0TUhOeiZyZW1hcmtzPVRGWXpMZVdQc09hNXZrZERVQzFDTFRF";
    assert(SSRInfo.fromRawString(content, isBase64: true).host == 'hello.foo');
  });

  test("parse ssr subs data", () async {
    final secret = jsonDecode(File("./secret.json").readAsStringSync());
    final sub = Subscription(secret['ssr_sub']);

    assert(await sub.update());
  });
}
