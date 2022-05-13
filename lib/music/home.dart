import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'model/myaudio.dart';
import 'playerControls.dart';
import 'albumart.dart';
import 'navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sliderValue = 2;

  Map audioData = {
    'image':
        'https://thegrowingdeveloper.org/thumbs/1000x1000r/audios/quiet-time-photo.jpg',
    'url':
        'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyNavigationBar(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            height: height / 2.5,
            child: AlbumArt(imageUrl: audioData['image']),
          ),
          Text(
            'Gidget',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: darkPrimaryColor),
          ),
          Text(
            'The Free Nationals',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: darkPrimaryColor),
          ),
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 5,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
                child: Consumer<MyAudio>(
                  builder: (_, myAudioModel, child) => Slider(
                    value: myAudioModel.position == null
                        ? 0
                        : myAudioModel.position!.inMilliseconds.toDouble(),
                    activeColor: darkPrimaryColor,
                    inactiveColor: darkPrimaryColor.withOpacity(0.3),
                    onChanged: (value) {
                      myAudioModel
                          .seekAudio(Duration(milliseconds: value.toInt()));
                    },
                    min: 0,
                    max: myAudioModel.totalDuration == null
                        ? 20
                        : myAudioModel.totalDuration!.inMilliseconds.toDouble(),
                  ),
                ),
              ),
            ],
          ),
          PlayerControls(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
