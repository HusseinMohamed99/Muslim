import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_app/model/hadith_details.dart';
import 'package:muslim_app/shared/adaptive/indicator.dart';
import 'package:muslim_app/shared/components/indicator.dart';
import 'package:muslim_app/shared/components/size_box.dart';
import 'package:muslim_app/shared/providers/settings_provider.dart';
import 'package:muslim_app/shared/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = 'HadithDetailsScreen';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    HadithDetailsArg argNames =
        (ModalRoute.of(context)?.settings.arguments) as HadithDetailsArg;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(settingsProvider.getBackgroundImage()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
           AppLocalizations.of(context)!.app_title,
            style: GoogleFonts.elMessiri(),
          ),
        ),
        body: argNames.content.isEmpty
            ? Center(child: AdaptiveIndicator(os: getOs()))
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  color: settingsProvider.isDarkMode()
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  elevation: 12,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: settingsProvider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black,
                                radius: 15,
                                child: Icon(
                                  FontAwesomeIcons.circlePlay,
                                  color: settingsProvider.isDarkMode()
                                      ? Colors.black
                                      : Colors.white,
                                )),
                            const Space(width: 10, height: 0),
                            FittedBox(
                              child: Text(
                                argNames.title,
                                style: GoogleFonts.elMessiri(
                                  fontSize: 30,
                                  color: settingsProvider.isDarkMode()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 3.0,
                          color: ThemeApp.lightPrimary,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            argNames.content,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 25,
                              color: settingsProvider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
