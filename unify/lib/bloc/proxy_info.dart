import 'package:unify/utils.dart' as utils;

enum ProxyType { V2ray, SSR, Unsupported }

class Proxy<T extends ProxyInfo> {
  final ProxyType type;
  final T node;
  Proxy(this.type, this.node);
}

abstract class ProxyInfo {}

class SSRInfo extends ProxyInfo {
  String host;
  String port;
  String method;
  String password;
  String remark;
  String protocol;
  String protocolParam;
  String obfs;
  String obfsParam;

  SSRInfo(this.host, this.port, this.method, this.password,
      {this.remark,
      this.protocol,
      this.protocolParam,
      this.obfs,
      this.obfsParam});

  SSRInfo.fromRawString(String source, {isBase64: false}) {
    // URL Scheme: ssr://host:port:protocol:method:obfs:base64(password)/?protocolParam=base64(x)&obfsParam=base64(x)&remark=base64(x)
    final l1 = isBase64 ? utils.base64Decode(source) : source;
    final l2 = l1.split('/?');
    final l3 = l2.first.split(':');
    final l4 = l2.last.split('&');

    host = l3[0];
    port = l3[1];
    protocol = l3[2];
    method = l3[3];
    obfs = l3[4];
    password = utils.base64Decode(l3[5]);
    protocolParam = utils.base64Decode(l4[0].split('=').last);
    obfsParam = utils.base64Decode(l4[1].split('=').last);
    remark = utils.base64Decode(l4[2].split('=').last);
  }

  SSRInfo.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    port = json['port'];
    method = json['method'];
    password = json['password'];
    remark = json['remark'];
    protocol = json['protocol'];
    protocolParam = json['protocolParam'];
    obfs = json['obfs'];
    obfsParam = json['obfsParam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['port'] = this.port;
    data['method'] = this.method;
    data['password'] = this.password;
    data['remark'] = this.remark;
    data['protocol'] = this.protocol;
    data['protocolParam'] = this.protocolParam;
    data['obfs'] = this.obfs;
    data['obfsParam'] = this.obfsParam;
    return data;
  }
}

class V2rayInfo extends ProxyInfo {
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
