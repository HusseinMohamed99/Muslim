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
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            Expanded(child: _buildRadioList()),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      flex: 1,
      child: Image.asset('assets/images/radio.png'),
    );
  }

  Widget _buildRadioList() {
    return FutureBuilder<List<Radios>>(
      future: Api.getRadios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return _buildError();
        }
        var radios = snapshot.data ?? [];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) => RadioItem(radios[index]),
          itemCount: radios.length,
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: ThemeApp.darkPrimary,
        valueColor: AlwaysStoppedAnimation<Color>(ThemeApp.lightPrimary),
        strokeWidth: 5,
      ),
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text(
        'Something went wrong',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}

class Api {
  static Future<List<Radios>> getRadios() async {
    final url = Uri.https('mp3quran.net', '/api/v3/radios');
    final response = await http.get(url);
    final data =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final radioResponse = RadioModel.fromJson(data);
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
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRadioName(settingsProvider),
          const SizedBox(height: 50),
          _buildControlButtons(settingsProvider),
        ],
      ),
    );
  }

  Widget _buildRadioName(SettingsProvider settingsProvider) {
    return Text(
      widget.radio.name ?? '',
      style: GoogleFonts.elMessiri(
        fontSize: 20.sp,
        color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildControlButtons(SettingsProvider settingsProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton('assets/images/Icon-metro.png',
            () => audioPlayer.pause(), settingsProvider),
        const SizedBox(width: 10),
        _buildIconButton(
          'assets/images/Icon-awesome-play.png',
          _togglePlayPause,
          settingsProvider,
        ),
        _buildIconButton('assets/images/Icon-metro-next.png',
            () => audioPlayer.pause(), settingsProvider),
      ],
    );
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed,
      SettingsProvider settingsProvider) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        assetPath,
        color: settingsProvider.isDarkMode()
            ? ThemeApp.yellow
            : ThemeApp.lightPrimary,
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (audioPlayer.state == PlayerState.playing) {
        audioPlayer.pause();
      } else {
        audioPlayer.play(UrlSource(widget.radio.url ?? ''));
      }
    });
  }
}
