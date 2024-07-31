import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:sky_scrapper/screen/home/model/home_model.dart';
import 'package:sky_scrapper/utils/api_helper.dart';
import 'package:sky_scrapper/utils/shared_helper.dart';

class HomeProvider with ChangeNotifier {
  HomeModel? homeModel;
  bool isOn = true;
  bool theme = false;
  bool changeTheme = false;
  ThemeMode mode = ThemeMode.light;
  IconData themeMode = Icons.dark_mode;
  bool isLight = false;
  List<String> bookList = [];
  String? getUrl;

  Future<void> weatherGetData(String city) async {
    HomeModel? weatherData = await APIHelper.apiHelper.weatherData(city);
    homeModel = weatherData;
    notifyListeners();
  }

  void setTheme() async {
    theme = !theme;
    saveTheme(changeTheme: theme);
    changeTheme = (await applyTheme())!;
    if (changeTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (changeTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void getTheme() async {
    if (await applyTheme() == null) {
      changeTheme = false;
    } else {
      changeTheme = (await applyTheme())!;
    }
    if (changeTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (changeTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void checkInternet() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isOn = false;
      } else {
        isOn = true;
      }
      notifyListeners();
    });
  }

  void getData() async {
    if (await applyData() == null) {
      bookList = [];
    } else {
      bookList = (await applyData())!;
    }
    notifyListeners();
  }

  void setData(String city) {
    getData();
    bookList.add(city);
    saveData(bookMark: bookList);
    getData();
    notifyListeners();
  }

  void deleteContact(int r) {
    getData();
    bookList.removeAt(r);
    saveData(bookMark: bookList);
    getData();
    notifyListeners();
  }
}
