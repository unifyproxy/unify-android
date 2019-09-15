import 'dart:convert' as convert;

import 'package:unify/bloc/proxy_info.dart';

String base64Decode(String source) =>
    convert.utf8.decode(convert.base64Decode(convert.base64.normalize(source)));

bool isV2rayIdentical(V2rayInfo a, V2rayInfo b) =>
    a.host == b.host &&
    a.port == b.port &&
    a.add == b.add &&
    a.path == b.path &&
    a.id == b.id;

bool isSSRIdentical(SSRInfo a, SSRInfo b) =>
    a.host == b.host && a.port == b.port;
