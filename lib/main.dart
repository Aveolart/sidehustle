import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var humidity;
  var windSpeed;
  var time;
  var country;
  var update;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=8ecf2c64470d44d7b6a102146210207&q=Lagos&aqi=yes"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['current']['temp_c'];
      this.description = results['current']['condition']['text'];
      this.time = results['location']['localtime'];
      this.humidity = results['current']['humidity'];
      this.windSpeed = results['current']['wind_mph'];
      this.country = results['location']['country'];
      this.update = results['current']['last_updated'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/unnamed.gif"),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Lagos Weather",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u2103" : "Loading",
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    time != null ? time.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(9.0),
            child: ListView(children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerQuarter),
                title: Text("Temperature"),
                trailing:
                    Text(temp != null ? temp.toString() + "\u2103" : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloudMeatball),
                title: Text("Weather"),
                trailing: Text(
                    description != null ? description.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing:
                    Text(humidity != null ? humidity.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing:
                    Text(windSpeed != null ? windSpeed.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.flag),
                title: Text("Country"),
                trailing:
                    Text(country != null ? country.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.solidClock),
                title: Text("Last Updated"),
                trailing: Text(update != null ? update.toString() : "Loading"),
              ),
            ]),
          )),
        ],
      ),
    );
  }
}
