import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          title: Text(
            "Back",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(5)),
            Text(
              "PRESCRIPTION",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Row(
              children: <Widget>[
                Text(
                  "Keterangan",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Container(
              width: double.infinity,
              height: 180.0,
              margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            Row(
              children: <Widget>[
                Text(
                  "Rekomendasi",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Container(
              width: double.infinity,
              height: 180.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
