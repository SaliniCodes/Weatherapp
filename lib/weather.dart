import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'models/weatherModel.dart';
class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherModel? weather  ;
  Future<void> fetchData() async {
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=02670d17832043db80c63727241701&q=kochi');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final model = WeatherModel.fromJson(data);
      setState(() {
        weather = model;
      });
    } else {
      print('error: ${response.statusCode}');
    }
  }
  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body:weather==null?Center(child: CircularProgressIndicator()):Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1563630381190-77c336ea545a?q=80&w=1378&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.more_vert,size:40),
                    onPressed: () {
                      // Handle tapping the comment icon
                    },
                  ),

                ],
              ),
            ),
            SizedBox(height:100),
            Text(weather!.location.name,style: GoogleFonts.lato(fontSize: 20,fontWeight:FontWeight.w900),
            ),
            Text(weather!.current.lastUpdated,  style: GoogleFonts.lato(),
            ),
            SizedBox(height:150),
            Text(weather!.current.tempC.toString(),  style: GoogleFonts.lato(fontSize: 20,fontWeight:FontWeight.w900),
            ),
            Text('Good Night wasim',  style: GoogleFonts.lato(fontSize:10),
            ),
            SizedBox(height: 100,),
            Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Container(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.sunny_snowing,size:30),
                        onPressed: () {
                          // Handle tapping the comment icon
                        },
                      ),
                      Text(weather!.current.cloud.toString(),  style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w900),
                      ),
                      Text('7:00',style: GoogleFonts.lato(fontSize: 15,) ),
                    ],
                  ),
                ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.wind_power,size:30),
                          onPressed: () {
                            // Handle tapping the comment icon
                          },
                        ),
                        Text(weather!.current.windDir,style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w900)),
                        Text('4M/S',style: GoogleFonts.lato(fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cloud,size:30),
                          onPressed: () {
                            // Handle tapping the comment icon
                          },
                        ),
                        Text(weather!.current.tempF.toString(),style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w900)),
                        Text('23 \u2109',style: GoogleFonts.lato(fontSize: 15)),
                      ],
                    ),
                  ),],
              ),
            )


          ],
        ),
        ),
        ));
  }
}