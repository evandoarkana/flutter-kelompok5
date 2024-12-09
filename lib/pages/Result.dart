import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Result extends StatefulWidget {
  final String city;

  const Result({Key? key, required this.city}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String? weatherDescription;
  String? temperature;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    String apiKey = '355aa14314f78467c9a15e4c97730470';
    String city = widget.city;
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          weatherDescription = data['weather'][0]['description'];
          temperature = data['main']['temp'].toString();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Kota tidak ditemukan';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Terjadi kesalahan, coba lagi';
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Tracking Cuaca'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : errorMessage != null
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cuaca di kota: ${widget.city}',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Temperatur: $temperature°C',
                            style: const TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Deskripsi Cuaca: $weatherDescription',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 30),
                          Icon(
                            Icons.wb_sunny,
                            size: 100,
                            color: Colors.yellow.shade700,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
