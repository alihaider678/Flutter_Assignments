import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Matching Game",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemModel>? hand;
  List<ItemModel>? number;
  void sound(String sond) {
    final player = AssetsAudioPlayer();
    player.open(
      Audio(sond),
    );
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    hand = [
      ItemModel(num: 1, image: "assets/1.jpg", accepting: false),
      ItemModel(num: 2, image: "assets/2.jpg", accepting: false),
      ItemModel(num: 3, image: "assets/3.jpg", accepting: false),
      ItemModel(num: 4, image: "assets/4.jpg", accepting: false),
      ItemModel(num: 5, image: "assets/5.jpg", accepting: false),
    ];
    number = List<ItemModel>.from(hand!);
    hand?.shuffle();
    number?.shuffle();
  }

  var first;
  var second;
  @override
  Widget build(BuildContext context) {
    if (number?.length == 0) {
      return HomePage();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text('Matching Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                    children: hand!.map((item) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            first = item;
                          });
                        },
                        child: Container(
                          child: Image.asset(
                            item.image ?? "",
                            height: 70,
                            width: 70,
                          ),
                        ),
                      );
                    }).toList()),
                Spacer(),
                Column(
                    children: number!.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: GestureDetector(
                          onTap: () {
                            if (first.num == item.num) {
                              sound("assets/correct.wav");
                              setState(() {
                                number?.remove(item);
                                hand?.remove(first);
                              });
                            } else {
                              sound("assets/wrong.wav");
                            }
                          },
                          child: Text(
                            item.num.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    }).toList()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final int? num;
  final String? image;
  bool accepting;

  ItemModel({this.image, this.num, this.accepting = false});
}
