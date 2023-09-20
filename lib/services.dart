import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestMethod {
  Future apiRequest(
    String endPoint,
    METHOD method,
    Map body,
    String token,
  ) async {
    http.Response resp;
    final String url = "http://document.apibag.in:3001" + endPoint;
    final Map<String, String> headers = new Map<String, String>();
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');

    if (token != "" && token.isNotEmpty) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer ' + token);
    }
    print(url);

    try {
      if (method == METHOD.GET) {
        resp = await http.get(
          Uri.parse(url),
          // headers: headers,
        );

        return json.decode(resp.body);
      } else if (method == METHOD.GET_BAL) {
        resp = await http.get(
          Uri.parse(url),
          // headers: headers,
        );
        return [resp.statusCode, json.decode(resp.body)];
      } else if (method == METHOD.PUT) {
        resp = await http.put(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
      } else if (method == METHOD.POST) {
        resp = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
        return json.decode(resp.body);
      } else if (method == METHOD.DELETE) {
        resp = await http.delete(
          Uri.parse(url),
          // headers: headers,
        );
      } else if (method == METHOD.PATCH) {
        resp = await http.patch(Uri.parse(url), body: body);
        return json.decode(resp.body);
      }
      // if (resp == null && this.validateResponse(resp)) {
      //   return json.decode(resp.body);
      // }
      // else {
      //   Response resp = new Response();
      //   resp.respMsg = LocalConstants.genericError;
      //   resp.respCode = LocalConstants.resp_failure;
      //   Response.
      // }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      //handleTimeout();
    } on SocketException catch (e) {
      print('Socket Error: $e');
      //handleTimeout();
    } on Error catch (e) {
      print('General Error: $e');
      //showError();
      // return resp.statusCode;
    }
  }
}

enum METHOD {
  GET,
  GET_BAL,
  PUT,
  FUTURE_GET,
  POST,
  DELETE,
  PATCH,
  MULTIPART,
}
