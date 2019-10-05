import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  test('Weather API test', () async {
    var response = await http.get('https://samples.openweathermap.org/data/2.5/weather?q=Dubai,DE&appid=b6907d289e10d714a6e88b30761fae22');
    var jsonResponse = convert.jsonDecode(response.body);
    print(((jsonResponse['main']['temp'] - 273) as double).toStringAsFixed(2));
//    print(jsonResponse['main']['temp']);
  });
}