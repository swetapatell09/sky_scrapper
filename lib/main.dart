import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/screen/home/provider/home_provider.dart';
import 'package:sky_scrapper/utils/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
      ],
      child: Consumer<HomeProvider>(builder: (context, value, child) {
        value.getTheme();
        value.theme = value.changeTheme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: app_route,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value.mode,
        );
      }),
    ),
  );
}
