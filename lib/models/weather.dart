class Weather {
  final double temperature;
  final String description;
  final String city;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
      city: city,
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }
}
