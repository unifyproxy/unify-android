import 'dart:convert';

import 'package:http/http.dart' as http;

class Subscription {
  final String url;
  final String name;

  List<Node> _nodes;

  List<Node> get node => _nodes;

  Subscription(this.url, {this.name: "untitled"});

  Node parseNode(String source) {
    final contents = source.split('/');
    final protocol = contents.first;
    final contentString = String.fromCharCodes(base64Decode(contents.last));

    if (protocol == 'vmess:') {
      // nodeType = NodeType.V2ray;
      return Node<V2rayInfo>(
        NodeType.V2ray,
        V2rayInfo.fromJson(json.decode(contentString)),
      );
    } else if (protocol == 'ssr:') {
      // nodeType = NodeType.SSR;
      // TODO: Implement it
    } else {
      // nodeType = NodeType.Unsupported;
      return Node(NodeType.Unsupported, null);
    }
  }

  Future<bool> update() async {
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<Node> nodes = [];
      final urls = String.fromCharCodes(base64Decode(res.body));

      for (var url in urls.split('\n')) {
        nodes.add(parseNode(url));
      }

      _nodes = nodes;
      return true;
    }
    return false;
  }
}

enum NodeType { V2ray, SSR, Unsupported }

class Node<T extends NodeInfo> {
  final NodeType type;
  final T node;
  Node(this.type, this.node);
}

abstract class NodeInfo {}

class SSRInfo extends NodeInfo {}

class V2rayInfo extends NodeInfo {
  String add;
  String aid;
  String host;
  String id;
  String net;
  String path;
  String port;
  String ps;
  String tls;
  String type;
  String v;

  V2rayInfo(
      {this.add,
      this.aid,
      this.host,
      this.id,
      this.net,
      this.path,
      this.port,
      this.ps,
      this.tls,
      this.type,
      this.v});

  V2rayInfo.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    aid = json['aid'];
    host = json['host'];
    id = json['id'];
    net = json['net'];
    path = json['path'];
    port = json['port'];
    ps = json['ps'];
    tls = json['tls'];
    type = json['type'];
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add'] = this.add;
    data['aid'] = this.aid;
    data['host'] = this.host;
    data['id'] = this.id;
    data['net'] = this.net;
    data['path'] = this.path;
    data['port'] = this.port;
    data['ps'] = this.ps;
    data['tls'] = this.tls;
    data['type'] = this.type;
    data['v'] = this.v;
    return data;
  }
}

class SubscriptionBloc {
  List<Subscription> _subs = <Subscription>[];

  List<Subscription> get subs => _subs;

  bool addSub(Subscription sub) {
    if (!_subs.any((s) => s.url == sub.url)) {
      RegExp reg = RegExp(
          "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)",
          unicode: true,
          multiLine: true);
      final result = reg.hasMatch(sub.url);
      if (!result) {
        return false;
      }
      _subs.add(sub);
      return true;
    }
    return false;
  }

  removeSub(Subscription sub) {
    _subs = _subs.where((s) => s.url != sub.url).toList();
  }

  testSub(String url) async {
    final res = await http.get(url);
    print(res.body);
    return res.statusCode == 200;
  }
}
