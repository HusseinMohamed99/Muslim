part of './../../core/helpers/export_manager/export_manager.dart';

class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({super.key});
  static const String routeName = 'HadithDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final HadithDetailsArg argNames =
        ModalRoute.of(context)?.settings.arguments as HadithDetailsArg;

    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color backgroundColor = isDarkMode ? Colors.white : Colors.black;
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;
    final Color dividerColor =
        isDarkMode ? ThemeApp.yellow : ThemeApp.lightPrimary;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(settingsProvider.getBackgroundImage()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: GoogleFonts.elMessiri(),
          ),
        ),
        body: argNames.content.isEmpty
            ? const Center(child: AdaptiveIndicator())
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  color: cardColor,
                  elevation: 12,
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12).r,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(context, argNames.title, backgroundColor),
                        _buildDivider(dividerColor),
                        _buildContent(argNames.content, isDarkMode),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, String title, Color backgroundColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Space(width: 10.w, height: 0),
        CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 15.r,
          child: Icon(
            FontAwesomeIcons.circlePlay,
            color:
                backgroundColor == Colors.white ? Colors.black : Colors.white,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.elMessiri(
            fontSize: 25.sp,
            color:
                backgroundColor == Colors.white ? Colors.white : Colors.black,
          ),
        ),
        Space(width: 10.w, height: 0),
      ],
    );
  }

  Widget _buildDivider(Color color) {
    return Container(
      width: double.infinity,
      height: 3.0.h,
      color: color,
    );
  }

  Widget _buildContent(String content, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).r,
      alignment: Alignment.center,
      child: Text(
        content,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 25.sp,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
