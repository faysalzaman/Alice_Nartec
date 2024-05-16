import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:grosshop/screens/AssignedStutdents/add_sudents_screen.dart';

import 'package:http/http.dart' as http;

class CallingScreen extends StatefulWidget {
  final String userId;
  final List<String> associateId;

  CallingScreen({
    Key? key,
    required this.userId,
    required this.associateId,
  }) : super(key: key);

  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  // Define variables for audio player and ringtone player
  late AudioPlayer audioPlayer;
  late FlutterRingtonePlayer ringtonePlayer;

  bool _isPressed = false;

  void setRandomValue() {
    Random random = new Random();
    _isPressed = random.nextBool();
  }

  Future<void> _deleteQById(
    String userId,
    List<String> associateId,
  ) async {
    final String url = 'http://gs1ksa.org:4000/api/PostQueueDeleteById';
    final uri = Uri.parse(url);

    final headers = <String, String>{
      'Host': 'gs1ksa.org',
      'Content-Type': 'application/json',
    };

    final body = {"userId": userId, "userIdAssociateNo": associateId};

    try {
      final response =
          await http.delete(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print("***status code 200****");
        print(jsonData);

        Get.off(() => AddStudentScreen());

        Get.snackbar(
          "Call Ended",
          "Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        print("status code 400");

        audioPlayer.stop();
        FlutterRingtonePlayer.stop();
        Get.off(() => AddStudentScreen());

        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();

    print('userId: ${widget.userId}');
    print('associateId: ${widget.associateId}');

    // Initialize audio player and ringtone player
    audioPlayer = AudioPlayer();
    ringtonePlayer = FlutterRingtonePlayer();

    FlutterRingtonePlayer.play(
      fromAsset: "assets/ringtone/beep.mp3",
      ios: IosSounds.glass,
      looping: true,
    );
  }

  @override
  void dispose() {
    super.dispose();

    audioPlayer.stop();
    FlutterRingtonePlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 98, 171, 100),
                  Color.fromARGB(255, 16, 113, 19),
                ],
              ),
            ),
            child: Center(
              child: const Text(
                "Calling...",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              // onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: () {
                _deleteQById(
                  widget.userId,
                  widget.associateId,
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _isPressed ? 150.0 : 200.0,
                height: _isPressed ? 50.0 : 60.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: _isPressed
                      ? BorderRadius.circular(25.0)
                      : BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "End Call",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            // // Add a button to start the call
            // ElevatedButton(
            //   child: Text("Start Call"),
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.green,
            //     onPrimary: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(32.0),
            //     ),
            //   ),
            //   onPressed: () async {
            //     // // Play the ringtone
            //     // FlutterRingtonePlayer.play(
            //     //   android: AndroidSounds.ringtone,
            //     //   ios: IosSounds.glass,
            //     //   looping: true,
            //     //   asAlarm: false,
            //     // );

            //     // Play the ringtone from a local file
            //     FlutterRingtonePlayer.play(
            //       fromAsset: "assets/ringtone/beep.mp3",
            //       ios: IosSounds.glass,
            //       looping: true,
            //     );

            //     // Play the audio
            //     // await FlutterRingtonePlayer.play(
            //     //   "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
            //     //   isLocal: false,
            //     // );
            //   },
            // ),
            // // Add a button to end the call
            // ElevatedButton(
            //   child: Text("End Call"),
            //   onPressed: () {
            //     // Stop playing the ringtone and audio
            //     FlutterRingtonePlayer.stop();
            //     audioPlayer.stop();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
