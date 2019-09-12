import 'dart:convert' as convert;

String base64Decode(String source) =>
    convert.utf8.decode(convert.base64Decode(convert.base64.normalize(source)));
