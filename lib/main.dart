import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _temperature;
  int _humidity;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeatherData();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Interview app',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 8.0,
                ),
                child: Align(
                  child: Text(
                    'Counter',
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              _buildCard(
                'You have hit the button',
                _counter.toString(),
                ' times',
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 8.0,
                  top: 32.0,
                ),
                child: Align(
                  child: Text(
                    'Weather',
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              _buildCard(
                'It is currenly',
                _isLoading ? '...' : _temperature,
                ' degree celsius',
              ),
              _buildCard(
                'With a humidity of',
                _isLoading ? '...' : _humidity.toString(),
                ' %',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: RaisedButton(
                  child: Text('Add count'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: _incrementCounter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildCard(String title, String subtitleOne, String subtitleTwo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 10.0,
        child: Container(
          height: 100.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(subtitleOne,
                          style: Theme.of(context).textTheme.display1),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          subtitleTwo,
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.get(
          'https://samples.openweathermap.org/data/2.5/weather?q=Dubai,DE&appid=b6907d289e10d714a6e88b30761fae22');
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        _temperature =
            ((jsonResponse['main']['temp'] - 273) as double).toStringAsFixed(2);
        _humidity = jsonResponse['main']['humidity'];
      });
      print(jsonResponse['main']['temp']);
    } catch (ex) {
      print(ex);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
