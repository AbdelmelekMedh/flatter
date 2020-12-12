import 'dart:convert';

import "package:http/http.dart" as http ;


class RequestResult {
  bool ok ;
  dynamic data;
  RequestResult(this.ok, this.data) ;


}

const PROTOCOL = "http" ;
const DOMAIN = "localhost:5000";


Future<RequestResult> http_get (String route , [dynamic data]) async
{
  var dataSr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataSr";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post (String route , [dynamic data]) async
{

  var url = "$PROTOCOL://$DOMAIN/$route";
  var dataSr = jsonEncode(data);
  var result = await http.post(url, body: dataSr , headers: {"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
