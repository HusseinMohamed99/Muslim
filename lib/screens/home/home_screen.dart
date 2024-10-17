part of './../../core/helpers/export_manager/export_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          AssetsPath.assetsImagesMuslim,
          width: 100.w,
          height: 100.h,
          fit: BoxFit.fitHeight,
        ),
        CustomAzkarCardItem(cardColor: cardColor, isDarkMode: isDarkMode),
        Space(width: 0, height: 20.h),
        const Expanded(
          child: CustomCardListView(),
        ),
      ],
    );
  }
}

class CustomAzkarCardItem extends StatelessWidget {
  const CustomAzkarCardItem({
    super.key,
    required this.cardColor,
    required this.isDarkMode,
  });

  final Color cardColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: Text(
          'قال رسول الله صلى الله عليه وسلم: سيد الاستغفار أن يقول العبد: اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء لك بذنبي فاغفر لي، فإنه لا يغفر الذنوب إلا أنت',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class CustomCardListView extends StatelessWidget {
  const CustomCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 4.h),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesRamadan,
                  title: 'اذكار الصباح',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 0,
                        ),
                      ),
                    );
                  },
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesMoon,
                  title: 'اذكار المساء',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 1,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Space(width: 0, height: 20),
            Row(
              children: [
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesGetUp,
                  title: 'اذكار الاستيقاظ',
                  voidCallback: () {},
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesSleeping,
                  title: 'اذكار النوم',
                  voidCallback: () {},
                ),
              ],
            ),
            const Space(width: 0, height: 20),
            Row(
              children: [
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesPrayer,
                  title: 'ادعية',
                  voidCallback: () {},
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesPraying,
                  title: 'اذكار بعد الصلاة',
                  voidCallback: () {},
                ),
              ],
            ),
            const Space(width: 0, height: 20),
            Row(
              children: [
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesZakat,
                  title: 'حساب الزكاه',
                  voidCallback: () {},
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Space(width: 0, height: 0);
      },
      itemCount: 1,
    );
  }
}

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key,
    required this.imageIcon,
    required this.title,
    required this.voidCallback,
  });
  final String imageIcon;
  final String title;
  final VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;

    return Expanded(
      child: GestureDetector(
        onTap: voidCallback,
        child: Card(
          color: cardColor,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Row(
              children: [
                Image.asset(
                  imageIcon,
                  width: 40.w,
                  height: 40.h,
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomHomeScreenDetails extends StatelessWidget {
  const CustomHomeScreenDetails({super.key, required this.currentIndex});
  static const String routeName = 'CustomHomeScreenDetails';
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final bool isDarkMode = settingsProvider.isDarkMode();
    final Color cardColor =
        isDarkMode ? Theme.of(context).primaryColor : Colors.white;
    List<String> morningAzkar = [
      'أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ \nاللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.  [آية الكرسى - البقرة 255].',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِد إِذَا حَسَدَ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.',
      'أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.',
      'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .',
      'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.',
      'اللهـم إنـي أصبـحت أشـهدك ، وأشـهد حملـة عـرشـك ، وملائكتك ، وجمـيع خلـقك ، أنـك أنـت الله لا إله إلا أنـت وحـدك لا شريك لـك ، وأن محمـدا عبـدك ورسـولـك.',
      'اللهـم ما أصبـح بي مـن نعـمة أو بأحـد مـن خلـقك ، فمـنك وحـدك لا شريك لـك ، فلـك الحمـد ولـك الشكـر.',
      'حسبـي الله لا إله إلا هو علـيه توكـلت وهو رب العرش العظـيم.',
      'بسـم الله الذي لا يضـر مع اسمـه شيء في الأرض ولا في السمـاء وهـو السمـيع العلـيم.',
      'اللهـم بك أصـبحنا وبك أمسـينا ، وبك نحـيا وبك نمـوت وإلـيك النـشور.',
      'أصبـحـنا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد صلى الله عليه وسلم، وعلى ملة أبينا إبراهيم حنيفا مسلما وما كان من المشركين.',
    ];
    List<String> morningAzkarNumber = [
      '1',
      '3',
      '3',
      '3',
      '1',
      '1',
      '3',
      '4',
      '1',
      '7',
      '3',
      '1',
      '1',
    ];
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
            style: GoogleFonts.elMessiri(
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
            ),
          ),
        ),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 4.h),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (currentIndex == 0) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: morningAzkar[index],
                  number: morningAzkarNumber[index],
                ),
              );
            } else if (currentIndex == 1) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: '',
                  number: '',
                ),
              );
            }
            return null;
          },
          separatorBuilder: (context, index) {
            return const Space(width: 0, height: 0);
          },
          itemCount: newMethod(morningAzkar),
        ),
      ),
    );
  }

  int newMethod(List<String> morningAzkar) {
    int? length;
    if (currentIndex == 0) {
      length = morningAzkar.length;
    } else if (currentIndex == 1) {
      length = 3;
    }
    return length!;
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.cardColor,
    required this.isDarkMode,
    required this.index,
    required this.morningAzkar,
  });

  final Color cardColor;
  final bool isDarkMode;
  final int index;
  final AzkarModel morningAzkar;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              morningAzkar.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Space(width: 10, height: 0),
            Expanded(
              child: Card(
                elevation: 5,
                color: cardColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  child: Text(
                    morningAzkar.content,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AzkarModel {
  final String content;
  final String number;

  AzkarModel({required this.content, required this.number});
}
