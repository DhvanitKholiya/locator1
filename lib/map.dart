import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'global.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    Map data2 = ModalRoute.of(context)!.settings.arguments as Map;

    double lat = data2['lat'];
    double long = data2['long'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data2['name']}",
          style: const TextStyle(fontSize: 22),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            StreamBuilder(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR :- ${snapshot.hasError}"),
                    );
                  } else if (snapshot.hasData) {
                    Position? data2 = snapshot.hasData as Position?;

                    lat = data2!.latitude;
                    long = data2.longitude;
                    // data2['lat'] = data2!.latitude;
                    // data2['long'] = data2.longitude;

                    return (data2 != null)
                        ? Text(
                            "${data2.latitude}, ${data2.longitude}",
                            style: const TextStyle(fontSize: 22),
                          )
                        : const Center(
                            child: Text("No data....."),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
