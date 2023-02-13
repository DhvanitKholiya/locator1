import 'package:flutter/material.dart';
import 'package:locator/Global.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data['name']}",
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body:Column(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage('${data['logo']}'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: const Alignment(-0.9, 0),
              child: Text(
                "Since :- ${data['since']}",
                style: const TextStyle(fontSize: 18),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Description :- \n                    ${data['description']}",
                style: const TextStyle(fontSize: 14),
              )),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment(-0.9, 0),
              child: Text(
                "Wikipedia :-",
                style: TextStyle(fontSize: 18),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('web',arguments: data);
              },
              child: Text(
                "${data['webSite']}",
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              )),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment(-0.9, 0),
              child: Text(
                "Head Quoter Location :-",
                style: TextStyle(fontSize: 18),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('web',arguments: data['webSite']);
              },
              child: Text(
                "${data['lat']}",
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              )),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
