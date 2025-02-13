part of './../../core/helpers/export_manager/export_manager.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});
  static const String routeName = 'RadioScreen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImage(),
          const Expanded(child: RadioItem()),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      flex: 1,
      child: Image.asset('assets/images/radio.png'),
    );
  }
}

class RadioItem extends StatefulWidget {
  const RadioItem({super.key});

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRadioName(settingsProvider),
          const Space(width: 0, height: 50),
          _buildControlButtons(settingsProvider),
        ],
      ),
    );
  }

  Widget _buildRadioName(SettingsProvider settingsProvider) {
    return Text(
      settingsProvider.currentRadio?.name ?? '',
      textAlign: TextAlign.center,
      style:TextStyle(
        fontFamily: 'Elgharib',
        fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
        color: settingsProvider.isDarkMode() ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildControlButtons(SettingsProvider settingsProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(
          'assets/images/Icon-metro-next.png',
          () => nextRadio(settingsProvider),
          settingsProvider,
        ),
        _buildIconButton(
          'assets/images/Icon-awesome-play.png',
          () => _togglePlayPause(settingsProvider),
          settingsProvider,
        ),
        _buildIconButton(
          'assets/images/Icon-metro.png',
          () => previousRadio(settingsProvider),
          settingsProvider,
        ),
      ],
    );
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed,
      SettingsProvider settingsProvider) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        assetPath,
        width: 24.w,
        height: 24.h,
        color: settingsProvider.isDarkMode()
            ? ThemeApp.yellow
            : ThemeApp.lightPrimary,
      ),
    );
  }

  void _togglePlayPause(SettingsProvider settingsProvider) {
    setState(() {
      if (settingsProvider.radioPlayer.state == PlayerState.playing) {
        settingsProvider.radioPlayer.pause();
      } else {
        settingsProvider.radioPlayer
            .play(UrlSource(settingsProvider.currentRadio?.url ?? ''));
      }
    });
  }

  previousRadio(SettingsProvider settingsProvider) {
    if (settingsProvider.currentIndex == 0) {
      return;
    } else {
      settingsProvider.radioPlayer.stop();
      settingsProvider.isRadioPlay = false;
      settingsProvider.currentIndex--;
      settingsProvider.currentRadio =
          settingsProvider.radios![settingsProvider.currentIndex];
    }
  }

  nextRadio(SettingsProvider settingsProvider) {
    if (settingsProvider.currentIndex == settingsProvider.radios!.length - 1) {
      return;
    } else {
      settingsProvider.radioPlayer.stop();
      settingsProvider.isRadioPlay = false;
      settingsProvider.currentIndex++;
      settingsProvider.currentRadio =
          settingsProvider.radios![settingsProvider.currentIndex];
    }
  }
}
