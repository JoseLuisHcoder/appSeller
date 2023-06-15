import 'package:flutter/material.dart';
import 'package:vendedor/data/themes.dart';
import 'package:vendedor/presentation/screens/home/widgets/ben1.dart';

class Ben extends StatelessWidget {
  const Ben({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff000000),
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: Container(
        color: Color(0xff000000),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              child: Image.asset(
                'images/bs11.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ben1()));
                  },
                  child: Text('Ver mas')))
        ]),
      ),
    );
  }
}
