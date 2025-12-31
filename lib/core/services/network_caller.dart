import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
part '../models/network_response.dart';

class NetworkCaller{

   final Logger _logger = Logger();

   final VoidCallback onUnauthorize;
   final Map<String, String>? header;

  NetworkCaller({required this.onUnauthorize, required this.header});

   Future<NetworkResponse> getRequest({required String url})async{

    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri, headers: header
      );

      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if(response.statusCode == 200){
        // Success
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, responseCode: statusCode, responseData: decodedData);
      }else if(response.statusCode == 401){
        onUnauthorize();
        return NetworkResponse(isSuccess: false, responseCode: statusCode, responseData: null, errorMessage: 'Un-Authorized');
      }else{
        // Failed
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: false, responseCode: statusCode, responseData: decodedData, errorMessage: decodedData['data']);
      }
    } on Exception catch (e) {
      return NetworkResponse(isSuccess: false, responseCode: -1, responseData: null, errorMessage: e.toString());
    }


  }

   Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body})async{

    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);
      Response response = await post(
          uri,
          headers: header ?? {
            'content-type' : 'application/json',
          },
          body: jsonEncode(body)
      );

      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if(statusCode == 200 || statusCode == 201){
        // Success
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, responseCode: statusCode, responseData: decodedData);
      }else if(response.statusCode == 401){
        onUnauthorize();
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: false, responseCode: statusCode, responseData: null, errorMessage: decodedData['msg']);
      }else{
        // Failed
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: false, responseCode: statusCode, responseData: decodedData, errorMessage: decodedData['msg']);
      }
    } on Exception catch (e) {
      return NetworkResponse(isSuccess: false, responseCode: -1, responseData: null, errorMessage: e.toString());
    }


  }

   void _logRequest(String url, {Map<String, dynamic>? body}){
    _logger.i('URL => $url\n'
        'RequestBody => $body');
  }

   void _logResponse(String url, Response response){
    _logger.i('URL => $url\n'
        'StatusCode => ${response.statusCode}\n'
        'Body => ${response.body}');
  }


}