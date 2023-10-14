import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/radio_model.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});
  static const String routeName = 'RadioScreen';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/radio.png',
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Api.getRadios(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: ThemeApp.darkPrimary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ThemeApp.lightPrimary),
                          strokeWidth: 5,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "something went wrong",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }
                    var radios = snapshot.data ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RadioItem(radios[index]);
                      },
                      itemCount: radios.length,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Api {
  static Future<List<Radios>> getRadios() async {
    Uri url = Uri.https("mp3quran.net", "/api/v3/radios");
    http.Response response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    RadioModel radioResponse = RadioModel.fromJson(data);
    return radioResponse.radios ?? [];
  }
}

class RadioItem extends StatefulWidget {
  const RadioItem(this.radio, {super.key});
  final Radios radio;

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.radio.name ?? "",
            style: GoogleFonts.elMessiri(
              fontSize: 20.sp,
              color:
                  settingsProvider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioPlayer.pause();
                },
                icon: Image.asset(
                  'assets/images/Icon-metro.png',
                  color: settingsProvider.isDarkMode()
                      ? ThemeApp.yellow
                      : ThemeApp.lightPrimary,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      audioPlayer.state == PlayerState.playing
                          ? audioPlayer.pause()
                          : audioPlayer.play(
                              UrlSource(widget.radio.url ?? ""),
                            );
                    },
                  );
                },
                icon: Image.asset(
                  'assets/images/Icon-awesome-play.png',
                  color: settingsProvider.isDarkMode()
                      ? ThemeApp.yellow
                      : ThemeApp.lightPrimary,
                ),
              ),
              IconButton(
                onPressed: () async {
                  audioPlayer.pause();
                },
                icon: Image.asset(
                  'assets/images/Icon-metro-next.png',
                  color: settingsProvider.isDarkMode()
                      ? ThemeApp.yellow
                      : ThemeApp.lightPrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
