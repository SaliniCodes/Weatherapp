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
  TextEditingController messageController = TextEditingController();

  Future<void> fetchData(String Location) async {
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=02670d17832043db80c63727241701&q=$Location');

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
    fetchData("kochi");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body:weather==null?Center(child: CircularProgressIndicator()):Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(''),
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
                  Container(width: 200,
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Enter Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 100,),
                  GestureDetector(onTap: () => fetchData(messageController.text),
                      child:Container(height:20,width: 50,color:Colors.green,child: Text('Search'),),)
                ],
              ),
            ),
            SizedBox(height:100),
            Text(weather!.location.name,style: GoogleFonts.lato(fontSize: 20,fontWeight:FontWeight.w900),
            ),
            Text(weather!.current.lastUpdated.toString(),  style: GoogleFonts.lato(),
            ),

            SizedBox(height:100),

            Container(height:40,width:40,decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(weather!.current.condition.icon),
                fit: BoxFit.cover,
              ),
            ),),
            Text(weather!.current.tempC.toString(),  style: GoogleFonts.lato(fontSize: 20,fontWeight:FontWeight.w900),
            ),
            Text('Good Night wasim',  style: GoogleFonts.lato(fontSize:10),
            ),
            SizedBox(height: 50,),
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