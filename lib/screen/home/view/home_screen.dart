import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;
  TextEditingController txtName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().weatherGetData("surat");
    context.read<HomeProvider>().checkInternet();
    context.read<HomeProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sky Scrapper"),
        actions: [
          Switch(
            value: providerR!.changeTheme,
            onChanged: (value) {
              providerW!.setTheme();
            },
          ),
          IconButton(
            onPressed: () {
              bottom();
            },
            icon: const Icon(Icons.bookmark),
          ),
          providerW!.homeModel != null
              ? IconButton(
                  onPressed: () {
                    providerW!.setData(providerW!.homeModel!.name!);
                  },
                  icon: const Icon(Icons.favorite))
              : Container()
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (providerW!.homeModel == null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBar(
                      controller: txtName,
                      hintText: "Search City ",
                      trailing: [
                        IconButton(
                          onPressed: () {
                            providerR!.weatherGetData(txtName.text);
                            txtName.clear();
                          },
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text("No Data Found"),
                  ),
                ],
              )
            else if (providerW!.homeModel != null)
              providerW!.isOn == false
                  ? Container(
                      alignment: Alignment.center,
                      height: MediaQuery.sizeOf(context).height - 100,
                      width: MediaQuery.sizeOf(context).width,
                      child: Image.asset(
                        "assets/image/noConnection.png",
                        height: 200,
                        width: 200,
                      ),
                    )
                  : Stack(
                      children: [
                        providerW!.changeTheme == true
                            ? Image.asset(
                                "assets/image/sky_scrapper_dark.png",
                                height: MediaQuery.sizeOf(context).height - 100,
                                width: MediaQuery.sizeOf(context).width,
                                fit: BoxFit.cover,
                              )
                            : Image.asset("assets/image/sky_scrapper_light.png",
                                height: MediaQuery.sizeOf(context).height - 100,
                                width: MediaQuery.sizeOf(context).width,
                                fit: BoxFit.cover),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchBar(
                                controller: txtName,
                                hintText: "Search City",
                                trailing: [
                                  IconButton(
                                      onPressed: () {
                                        providerR!.weatherGetData(txtName.text);
                                      },
                                      icon: const Icon(Icons.search))
                                ],
                              ),
                            ),
                            Text(
                              "${providerW!.homeModel!.name}",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${providerW!.homeModel!.mainModel!.temp}°C",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Id",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.weatherlist![0].id}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "main",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.weatherlist![0].main}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.weatherlist![0].icon}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "temp",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.temp}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "feels_like",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.feels_like}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "temp_min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.temp_min}°C"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "temp_max",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.temp_max}°C"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "pressure",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.pressure}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "humidity",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.mainModel!.humidity}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "speed",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.wideModel!.speed} km/h"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "deg",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.wideModel!.deg}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "all",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.cloudsModel!.all}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "country",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.sysModel!.country}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "sunrise",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.sysModel!.sunrise}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "sunset",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.sysModel!.sunset}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "lon",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.coordModel!.lon}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "cod",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("${providerW!.homeModel!.cod}"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.grey],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "lat",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${providerW!.homeModel!.coordModel!.lat}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
            else
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }

  void bottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Favourite City",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: providerW!.bookList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          providerW!.weatherGetData(providerW!.bookList[index]);
                          Navigator.pop(context);
                        },
                        title: Text("${providerW!.bookList[index]}"),
                        trailing: IconButton(
                          onPressed: () {
                            providerW!.deleteContact(index);
                            providerW!.getData();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
