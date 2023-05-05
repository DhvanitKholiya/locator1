import 'package:flutter/material.dart';
import 'package:locator/detail.dart';
import 'package:locator/map.dart';
import 'package:locator/webPage.dart';

import 'Global.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const HomePage(),
      'detail': (context) => const DetailPage(),
      'web' : (context) => const WebPage(),
      'map' : (context) => const MapPage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Locator",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: Global.companyInfo.map((e) => GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('detail',arguments: e);
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  NetworkImage('${e['ceoImg']}'),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  "${e['name']}",
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  NetworkImage('${e['logo']}'),
                  backgroundColor: Colors.transparent,
                ),
                subtitle: Text(
                  "${e['ceoName']}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),).toList(),
        ),
      )
    );
  }
}


