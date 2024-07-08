import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sky_scrapper/screen/home/model/home_model.dart';

class APIHelper {
  static APIHelper apiHelper = APIHelper._();
  APIHelper._();
  Future<HomeModel?> weatherData(String city) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,&appid=5dd9048333848fd9169d22455b3563b1";
    var response = await http.get(
      Uri.parse(link),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      HomeModel homeModel = HomeModel.mapToModel(json);
      return homeModel;
    }
    return null;
  }
}
