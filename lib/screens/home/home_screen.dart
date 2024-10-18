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
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 2,
                        ),
                      ),
                    );
                  },
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesSleeping,
                  title: 'اذكار النوم',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 3,
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
                  imageIcon: AssetsPath.assetsImagesPrayer,
                  title: 'ادعية',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 4,
                        ),
                      ),
                    );
                  },
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesPraying,
                  title: 'اذكار بعد الصلاة',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomHomeScreenDetails(
                          currentIndex: 5,
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
                  imageIcon: AssetsPath.assetsImagesZakat,
                  title: 'حساب الزكاه',
                  voidCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomZakatScreenDetails(),
                      ),
                    );
                  },
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
      'سبحـان الله وبحمـده عدد خلـقه ، ورضـا نفسـه ، وزنـة عـرشـه ، ومـداد كلمـاتـه.'
          'اللهـم عافـني في بدنـي ، اللهـم عافـني في سمـعي ، اللهـم عافـني في بصـري ، لا إله إلا أنـت.',
      'اللهـم إنـي أعـوذ بك من الكـفر ، والفـقر ، وأعـوذ بك من عذاب القـبر ، لا إله إلا أنـت.',
      'اللهـم إنـي أسـألـك العـفو والعـافـية في الدنـيا والآخـرة ، اللهـم إنـي أسـألـك العـفو والعـافـية في ديني ودنـياي وأهـلي ومالـي ، اللهـم استـر عـوراتي وآمـن روعاتـي ، اللهـم احفظـني من بـين يدي ومن خلفـي وعن يمـيني وعن شمـالي ، ومن فوقـي ، وأعـوذ بعظمـتك أن أغـتال من تحتـي.',
      'يا حي يا قيوم برحمتك أستغيث أصلح لي شأني كله ولا تكلني إلى نفسي طـرفة عين. ',
      'أصبـحـنا وأصبـح المـلك لله رب العـالمـين ، اللهـم إنـي أسـألـك خـير هـذا الـيوم ، فـتحه ، ونصـره ، ونـوره وبـركتـه ، وهـداه ، وأعـوذ بـك مـن شـر ما فـيه وشـر ما بعـده.',
      'اللهـم عالـم الغـيب والشـهادة فاطـر السماوات والأرض رب كـل شـيء ومليـكه ، أشهـد أن لا إلـه إلا أنت ، أعـوذ بك من شـر نفسـي ومن شـر الشيـطان وشركه ، وأن أقتـرف علـى نفسـي سوءا أو أجـره إلـى مسـلم. ',
      'أعـوذ بكلمـات الله التـامـات من شـر ما خلـق.',
      'اللهم صل وسلم وبارك على نبينا محمد.',
      'اللهم إنا نعوذ بك من أن نشرك بك شيئا نعلمه ، ونستغفرك لما لا نعلمه. ',
      'اللهم إني أعوذ بك من الهم والحزن، وأعوذ بك من العجز والكسل، وأعوذ بك من الجبن والبخل، وأعوذ بك من غلبة الدين، وقهر الرجال.',
      'أستغفر الله العظيم الذي لا إله إلا هو، الحي القيوم، وأتوب إليه. ',
      'يا رب , لك الحمد كما ينبغي لجلال وجهك , ولعظيم سلطانك.',
      'اللهم إني أسألك علما نافعا، ورزقا طيبا، وعملا متقبلا.',
      'اللهم أنت ربي لا إله إلا أنت ، عليك توكلت ، وأنت رب العرش العظيم , ما شاء الله كان ، وما لم يشأ لم يكن ، ولا حول ولا قوة إلا بالله العلي العظيم , أعلم أن الله على كل شيء قدير ، وأن الله قد أحاط بكل شيء علما , اللهم إني أعوذ بك من شر نفسي ، ومن شر كل دابة أنت آخذ بناصيتها ، إن ربي على صراط مستقيم.',
      'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير. ',
      'سبحـان الله وبحمـده.',
      'أستغفر الله وأتوب إليه',
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
      '3',
      '3',
      '3',
      '1',
      '3',
      '1',
      '1',
      '3',
      '10',
      '3',
      '3',
      '3',
      '3',
      '1',
      '1',
      '100',
      '100',
      '100',
    ];
    List<String> moonAzkar = [
      'أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ \nاللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.  [آية الكرسى - البقرة 255].',
      'أعوذ بالله من الشيطان الرجيم \nآمن الرسول بما أنزل إليه من ربه والمؤمنون ۚ كل آمن بالله وملائكته وكتبه ورسله لا نفرق بين أحد من رسله ۚ وقالوا سمعنا وأطعنا ۖ غفرانك ربنا وإليك المصير. لا يكلف الله نفسا إلا وسعها لها ما كسبت وعليها ما اكتسبت ربنا لا تؤاخذنا إن نسينآ أو أخطأنا ربنا ولا تحمل علينا إصرا كما حملته على الذين من قبلنا ربنا ولا تحملنا ما لا طاقة لنا به واعف عنا واغفر لنا وارحمنا أنت مولانا فانصرنا على القوم الكافرين.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِد إِذَا حَسَدَ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.',
      'أمسيـنا وأمسـى المـلك لله والحمد لله ، لا إله إلا الله وحده لا شريك له، له المـلك وله الحمـد، وهو على كل شيء قدير ، رب أسـألـك خـير ما في هـذه اللـيلة وخـير ما بعـدهـا ، وأعـوذ بك من شـر ما في هـذه اللـيلة وشر ما بعـدهـا ، رب أعـوذبك من الكسـل وسـوء الكـبر ، رب أعـوذ بك من عـذاب في النـار وعـذاب في القـبر.',
      'اللهـم أنت ربـي لا إله إلا أنت ، خلقتنـي وأنا عبـدك ، وأنا علـى عهـدك ووعـدك ما استـطعـت ، أعـوذبك من شـر ما صنـعت ، أبـوء لـك بنعـمتـك علـي وأبـوء بذنـبي فاغفـر لي فإنـه لا يغـفر الذنـوب إلا أنت .',
      'رضيـت بالله ربـا وبالإسلام ديـنا وبمحـمد صلى الله عليه وسلم نبيـا.',
      'اللهـم إنـي أمسيت أشـهدك ، وأشـهد حملـة عـرشـك ، وملائكتك ، وجمـيع خلـقك ، أنـك أنـت الله لا إله إلا أنـت وحـدك لا شريك لـك ، وأن محمـدا عبـدك ورسـولـك.',
      'اللهـم ما أمسى بي مـن نعـمة أو بأحـد مـن خلـقك ، فمـنك وحـدك لا شريك لـك ، فلـك الحمـد ولـك الشكـر. ',
      'حسبـي الله لا إله إلا هو علـيه توكـلت وهو رب العرش العظـيم. ',
      'بسـم الله الذي لا يضـر مع اسمـه شيء في الأرض ولا في السمـاء وهـو السمـيع العلـيم. ',
      'اللهـم بك أمسـينا وبك أصـبحنا، وبك نحـيا وبك نمـوت وإلـيك المصير.',
      'أمسينا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد صلى الله عليه وسلم، وعلى ملة أبينا إبراهيم حنيفا مسلما وما كان من المشركين.',
      'سبحـان الله وبحمـده عدد خلـقه ، ورضـا نفسـه ، وزنـة عـرشـه ، ومـداد كلمـاتـه.',
      'اللهـم عافـني في بدنـي ، اللهـم عافـني في سمـعي ، اللهـم عافـني في بصـري ، لا إله إلا أنـت.',
      'اللهـم إنـي أعـوذ بك من الكـفر ، والفـقر ، وأعـوذ بك من عذاب القـبر ، لا إله إلا أنـت.',
      'اللهـم إنـي أسـألـك العـفو والعـافـية في الدنـيا والآخـرة ، اللهـم إنـي أسـألـك العـفو والعـافـية في ديني ودنـياي وأهـلي ومالـي ، اللهـم استـر عـوراتي وآمـن روعاتـي ، اللهـم احفظـني من بـين يدي ومن خلفـي وعن يمـيني وعن شمـالي ، ومن فوقـي ، وأعـوذ بعظمـتك أن أغـتال من تحتـي.',
      'يا حي يا قيوم برحمتك أستغيث أصلح لي شأني كله ولا تكلني إلى نفسي طـرفة عين.',
      'أمسينا وأمسى الملك لله رب العالمين، اللهم إني أسألك خير هذه الليلة فتحها ونصرها، ونورها وبركتها، وهداها، وأعوذ بك من شر ما فيها وشر ما بعدها.',
      'اللهـم عالـم الغـيب والشـهادة فاطـر السماوات والأرض رب كـل شـيء ومليـكه ، أشهـد أن لا إلـه إلا أنت ، أعـوذ بك من شـر نفسـي ومن شـر الشيـطان وشركه ، وأن أقتـرف علـى نفسـي سوءا أو أجـره إلـى مسـلم.',
      'أعـوذ بكلمـات الله التـامـات من شـر ما خلـق.',
      'اللهم صل وسلم وبارك على نبينا محمد.',
      'اللهم إنا نعوذ بك من أن نشرك بك شيئا نعلمه ، ونستغفرك لما لا نعلمه.',
      'اللهم إني أعوذ بك من الهم والحزن، وأعوذ بك من العجز والكسل، وأعوذ بك من الجبن والبخل، وأعوذ بك من غلبة الدين، وقهر الرجال.',
      'أستغفر الله العظيم الذي لا إله إلا هو، الحي القيوم، وأتوب إليه.',
      'يا رب , لك الحمد كما ينبغي لجلال وجهك , ولعظيم سلطانك.',
      'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.',
      'اللهم أنت ربي لا إله إلا أنت ، عليك توكلت ، وأنت رب العرش العظيم , ما شاء الله كان ، وما لم يشأ لم يكن ، ولا حول ولا قوة إلا بالله العلي العظيم , أعلم أن الله على كل شيء قدير ، وأن الله قد أحاط بكل شيء علما , اللهم إني أعوذ بك من شر نفسي ، ومن شر كل دابة أنت آخذ بناصيتها ، إن ربي على صراط مستقيم.',
      'سبحـان الله وبحمـده.',
    ];
    List<String> moonAzkarNumber = [
      '1',
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
      '3',
      '3',
      '3',
      '1',
      '3',
      '1',
      '1',
      '3',
      '10',
      '3',
      '3',
      '3',
      '3',
      '100',
      '1',
      '100',
    ];
    List<String> wakeUpAzkar = [
      'الحمـد لله الذي أحـيانا بعـد ما أماتـنا وإليه النـشور.',
      'الحمد لله الذي عافاني في جسدي ورد علي روحي وأذن لي بذكره.',
      'لا إله إلا الله وحـده لا شـريك له، له الملـك وله الحمـد، وهو على كل شيء قدير، سـبحان الله، والحمـد لله ، ولا إله إلا الله والله أكبر، ولا حول ولا قوة إلا بالله العلي العظيم. رب اغفر لي.',
    ];
    List<String> wakeUpAzkarNumber = [
      '1',
      '1',
      '1',
    ];
    List<String> sleepingAzkar = [
      'باسمك ربـي وضعـت جنـبي ، وبك أرفعـه، فإن أمسـكت نفسـي فارحـمها ، وإن أرسلتـها فاحفظـها بمـا تحفـظ به عبـادك الصـالحـين.',
      'اللهـم إنـك خلـقت نفسـي وأنـت توفـاهـا لك ممـاتـها ومحـياها ، إن أحييـتها فاحفظـها ، وإن أمتـها فاغفـر لـها . اللهـم إنـي أسـألـك العـافـية. ',
      'اللهـم قنـي عذابـك يـوم تبـعث عبـادك.',
      'باسـمك اللهـم أمـوت وأحـيا.',
      'الـحمد لله الذي أطـعمنا وسقـانا، وكفـانا، وآوانا، فكـم ممـن لا كـافي لـه ولا مـؤوي.',
      'اللهـم عالـم الغـيب والشـهادة فاطـر السماوات والأرض رب كـل شـيء ومليـكه، أشهـد أن لا إلـه إلا أنت، أعـوذ بك من شـر نفسـي، ومن شـر الشيـطان وشـركه، وأن أقتـرف علـى نفسـي سوءا أو أجـره إلـى مسـلم .',
      'اللهـم أسـلمت نفـسي إلـيك، وفوضـت أمـري إلـيك، ووجـهت وجـهي إلـيك، وألـجـات ظهـري إلـيك، رغبـة ورهـبة إلـيك، لا ملجـأ ولا منـجـا منـك إلا إلـيك، آمنـت بكتـابك الـذي أنزلـت وبنبـيـك الـذي أرسلـت.',
      'سبحان الله.',
      'الحمد لله.',
      'الله أكبر. ',
      'يجمع كفيه ثم ينفث فيهما والقراءة فيهما‏:‏ ‏{‏قل هو الله أحد‏}‏ و‏{‏قل أعوذ برب الفلق‏}‏ و‏{‏قل أعوذ برب الناس‏}‏ ومسح ما استطاع من الجسد يبدأ بهما على رأسه ووجه وما أقبل من جسده.',
      'سورة البقرة: أعوذ بالله من الشيطان الرجيم \nآمن الرسول بما أنزل إليه من ربه والمؤمنون ۚ كل آمن بالله وملائكته وكتبه ورسله لا نفرق بين أحد من رسله ۚ وقالوا سمعنا وأطعنا ۖ غفرانك ربنا وإليك المصير. لا يكلف الله نفسا إلا وسعها لها ما كسبت وعليها ما اكتسبت ربنا لا تؤاخذنا إن نسينا أو أخطأنا ربنا ولا تحمل علينا إصرا كما حملته على الذين من قبلنا ربنا ولا تحملنا ما لا طاقة لنا به واعف عنا واغفر لنا وارحمنا أنت مولانا فانصرنا على القوم الكافرين. [البقرة 285 - 286] ',
      'آية الكرسى: أعوذ بالله من الشيطان الرجيم \nالله لا إلـه إلا هو الحي القيوم لا تأخذه سنة ولا نوم له ما في السماوات وما في الأرض من ذا الذي يشفع عنده إلا بإذنه يعلم ما بين أيديهم وما خلفهم ولا يحيطون بشيء من علمه إلا بما شاء وسع كرسيه السماوات والأرض ولا يؤوده حفظهما وهو العلي العظيم. [البقرة 255]',
      'أذكار من قلق في فراشه ولم ينم \nعن بريدة رضي الله عنه، قال‏:‏ شكا خالد بن الوليد رضي الله عنه إلى النبي صلى الله عليه وسلم فقال‏:‏ يا رسول الله‏!‏ ما أنام الليل من الأرق، فقال النبي صلى الله عليه وسلم‏:‏ ‏"‏إذا أويت إلى فراشك فقل‏:‏ اللهم رب السموات السبع وما أظلت، ورب الأرضين وما أقلت، ورب الشياطين وما أضلت، كن لي جارا من خلقك كلهم جميعا أن يفرط علي أحد منهم أو أن يبغي علي، عز جارك، وجل ثناؤك ولا إله غيرك، ولا إله إلا أنت‏"عن عمرو بن شعيب، عن أبيه، عن جده: أن رسول الله صلى الله عليه وسلم كان يعلمهم من الفزع كلمات‏:‏ ‏"‏أعوذ بكلمات الله التامة من غضبه وشر عباده، ومن همزات الشياطين وأن يحضرون‏"',
      'أذكار الأحلام \nعن أبي قتادة رضي الله عنه قال‏:‏ قال رسول الله صلى الله عليه وسلم‏:‏ ‏"‏الرؤيا الصالحة‏"‏ وفي رواية ‏"‏الرؤيا الحسنة من الله، والحلم من الشيطان، فمن رأى شيئا يكرهه فلينفث عن شماله ثلاثا وليتعوذ من الشيطان، فإنها لا تضره‏".',
    ];
    List<String> sleepingAzkarNumber = [
      '1',
      '1',
      '3',
      '1',
      '1',
      '1',
      '1',
      '33',
      '33',
      '34',
      '3',
      '1',
      '1',
      '1',
      '1',
    ];
    List<String> adeia = [
      '"ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار". [البقرة - 201].',
      '"ربنا أفرغ علينا صبرا وثبت أقدامنا وانصرنا على القوم الكافرين". [البقرة - 250].',
      '"ربنا لا تؤاخذنا إن نسينا أو أخطأنا ربنا ولا تحمل علينا إصرا كما حملته على الذين من قبلنا ربنا ولا تحملنا ما لا طاقة لنا به واعف عنا واغفر لنا وارحمنا أنت مولانا فانصرنا على القوم الكافرين". [البقرة - 286].',
      '"ربنا لا تزغ قلوبنا بعد إذ هديتنا وهب لنا من لدنك رحمة إنك أنت الوهاب". [آل عمران - 8].',
      '"ربنا إننا آمنا فاغفر لنا ذنوبنا وقنا عذاب النار". [آل عمران - 16].',
      '"رب هب لي من لدنك ذرية طيبة إنك سميع الدعاء". [آل عمران - 38].',
      '"ربنا آمنا بما أنزلت واتبعنا الرسول فاكتبنا مع الشاهدين". [آل عمران - 53].',
      '"ربنا اغفر لنا ذنوبنا وإسرافنا في أمرنا وثبت أقدامنا وانصرنا على القوم الكافرين". [آل عمران - 147].',
      '"ربنا ما خلقت هذا باطلا سبحانك فقنا عذاب النار ربنا إنك من تدخل النار فقد أخزيته وما للظالمين من أنصار ربنا إننا سمعنا مناديا ينادي للإيمان أن آمنوا بربكم فآمنا ربنا فاغفر لنا ذنوبنا وكفر عنا سيئاتنا وتوفنا مع الأبرار ربنا وآتنا ما وعدتنا على رسلك ولا تخزنا يوم القيامة إنك لا تخلف الميعاد". [آل عمران -  191-194].',
      '"ربنا ظلمنا أنفسنا وإن لم تغفر لنا وترحمنا لنكونن من الخاسرين". [الأعراف - 23].',
      '"ربنا لا تجعلنا مع القوم الظالمين". [الأعراف - 47].',
      '"ربنا أفرغ علينا صبرا وتوفنا مسلمين". [الأعراف - 126].',
      '"حسبي الله لا إلـه إلا هو عليه توكلت وهو رب العرش العظيم". [التوبة - 129].',
      '"ربنا لا تجعلنا فتنة للقوم الظالمين ونجنا برحمتك من القوم الكافرين". [يونس - 85-86].',
      '"رب إني أعوذ بك أن أسألك ما ليس لي به علم وإلا تغفر لي وترحمني أكن من الخاسرين". [هود - 47].',
      '"رب اجعلني مقيم الصلاة ومن ذريتي ربنا وتقبل دعاء". [إبرهيم - 40].',
      '"ربنا اغفر لي ولوالدي وللمؤمنين يوم يقوم الحساب". [إبرهيم - 41].',
      '"رب أدخلني مدخل صدق وأخرجني مخرج صدق واجعل لي من لدنك سلطانا نصيرا". [الإسراء - 80].',
      '"ربنا آتنا من لدنك رحمة وهيئ لنا من أمرنا رشدا". [الكهف - 10].',
      '"رب اشرح لي صدري ويسر لي أمري واحلل عقدة من لساني يفقهوا قولي". [طه - 25-28].',
      '"رب زدني علما". [طه - 114].',
      '"لا إله إلا أنت سبحانك إني كنت من الظالمين". [الأنبياء - 87].',
      '"رب لا تذرني فردا وأنت خير الوارثين". [الأنبياء - 89].',
      '"رب أعوذ بك من همزات الشياطين وأعوذ بك رب أن يحضرون". [المؤمنون - 97-98].',
      '"ربنا آمنا فاغفر لنا وارحمنا وأنت خير الراحمين". [المؤمنون - 109].',
      '"رب اغفر وارحم وأنت خير الراحمين". [المؤمنون - 118].',
    ];
    List<String> adeiaNumber = [
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
    ];
    List<String> prayAzkar = [
      'أسـتغفر الله، أسـتغفر الله، أسـتغفر الله.اللهـم أنـت السلام ، ومـنك السلام ، تباركت يا ذا الجـلال والإكـرام .',
      'لا إله إلا الله وحده لا شريك له، له المـلك وله الحمد، وهو على كل شيء قدير، اللهـم لا مانع لما أعطـيت، ولا معطـي لما منـعت، ولا ينفـع ذا الجـد منـك الجـد.',
      'لا إله إلا الله, وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير، لا حـول ولا قـوة إلا بالله، لا إله إلا اللـه، ولا نعـبـد إلا إيـاه, له النعـمة وله الفضل وله الثـناء الحـسن، لا إله إلا الله مخلصـين لـه الدين ولو كـره الكـافرون. ',
      'سـبحان الله، والحمـد لله ، والله أكـبر.',
      'لا إله إلا الله وحـده لا شريك له، له الملك وله الحمد، وهو على كل شيء قـدير.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِد إِذَا حَسَدَ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.',
      'بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم \nقُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ.',
      'لا إله إلا الله وحـده لا شريك له، له الملك وله الحمد، يحيـي ويمـيت وهو على كل شيء قدير.',
      'اللهـم إنـي أسألـك علمـا نافعـا ورزقـا طيـبا ، وعمـلا متقـبلا. ',
      'اللهم أجرني من النار. ',
      'اللهم أعني على ذكرك وشكرك وحسن عبادتك. ',
    ];
    List<String> prayAzkarNumber = [
      '1',
      '1',
      '1',
      '33',
      '1',
      '3',
      '3',
      '3',
      '1',
      '10',
      '1',
      '7',
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
                  content: moonAzkar[index],
                  number: moonAzkarNumber[index],
                ),
              );
            } else if (currentIndex == 2) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: wakeUpAzkar[index],
                  number: wakeUpAzkarNumber[index],
                ),
              );
            } else if (currentIndex == 3) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: sleepingAzkar[index],
                  number: sleepingAzkarNumber[index],
                ),
              );
            } else if (currentIndex == 4) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: adeia[index],
                  number: adeiaNumber[index],
                ),
              );
            } else if (currentIndex == 5) {
              return CustomCard(
                cardColor: cardColor,
                isDarkMode: isDarkMode,
                index: index,
                morningAzkar: AzkarModel(
                  content: prayAzkar[index],
                  number: prayAzkarNumber[index],
                ),
              );
            }
            return null;
          },
          separatorBuilder: (context, index) {
            return const Space(width: 0, height: 0);
          },
          itemCount: newMethod(
            morningAzkar,
            moonAzkar,
            wakeUpAzkar,
            sleepingAzkar,
            adeia,
            prayAzkar,
          ),
        ),
      ),
    );
  }

  int newMethod(
    List<String> morningAzkar,
    moonAzkar,
    wakeUpAzkar,
    sleepingAzkar,
    adeia,
    prayAzkar,
  ) {
    int? length;
    if (currentIndex == 0) {
      length = morningAzkar.length;
    } else if (currentIndex == 1) {
      length = morningAzkar.length;
    } else if (currentIndex == 2) {
      length = wakeUpAzkar.length;
    } else if (currentIndex == 3) {
      length = sleepingAzkar.length;
    } else if (currentIndex == 4) {
      length = adeia.length;
    } else if (currentIndex == 5) {
      length = prayAzkar.length;
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
                fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
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

class CustomZakatScreenDetails extends StatefulWidget {
  const CustomZakatScreenDetails({super.key});

  @override
  State<CustomZakatScreenDetails> createState() =>
      _CustomZakatScreenDetailsState();
}

class _CustomZakatScreenDetailsState extends State<CustomZakatScreenDetails> {
  final TextEditingController controller = TextEditingController();
  double? zakat;
  void calculateZakat() {
    setState(() {
      double? amount = double.tryParse(controller.text);
      if (amount != null && amount > 0) {
        zakat = amount * 0.025;
      } else {
        zakat = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(calculateZakat);
  }

  @override
  void dispose() {
    controller.removeListener(calculateZakat);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDark = settingsProvider.isDarkMode();

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
            'حساب الزكاة',
            style: GoogleFonts.elMessiri(
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              children: [
                Text(
                  zakatBody,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Space(width: 0, height: 10),
                TextFormField(
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ادخل قيمة المال',
                    hintTextDirection: TextDirection.rtl,
                    labelStyle: GoogleFonts.elMessiri(
                      fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: !isDark
                            ? ThemeApp.darkPrimary
                            : ThemeApp.lightPrimary,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: !isDark
                            ? ThemeApp.darkPrimary
                            : ThemeApp.lightPrimary,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const Space(width: 0, height: 20),
                Text(
                  'الزكاة المستحقة',
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Space(width: 0, height: 20),
                Text(
                  zakat?.toString() ?? '0.0',
                  style: GoogleFonts.elMessiri(
                    fontSize: getResponsiveFontSize(context, fontSize: 15.sp),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String zakatBody =
    '''الزكاة هي الركن الثالث من أركان الإسلام الذي يأمر الإنسان بالتصدق وإعطاء جزء من المال للفقراء والمحتاجين. وهي عمل خيري إلزامي يهدف إلى دعم الفئات الأكثر فقراً في المجتمع. لأن التبرع بالمال للفقراء ينقي مال الأغنياء ويكفي الفقراء وعائلاتهم بتلبية اِحتياجاتهم الأساسية.

نصاب زكاة المال المعلوم هو 2.5% من إجمالى المال الذى يملكه الشخص لمدة سنة كاملة، ويجب على المسلم أن يدفع زكاته في الوقت المحدد لها، وهو بعد مرور سنة كاملة على المال الذي يملكه.

ما هو نصاب زكاة المال ؟
النصاب هو قيمة الحد الأدني التي يجب أن تصل إليها الأموال ليكون عليها الزكاة، وهو 85 جرام من الذهب أو ما يعادلها من العملات الأخرى. ويجب على المسلم أن يدفع زكاته في الوقت المحدد لها، وهو بعد مرور سنة كاملة على المال الذي يملكه.''';
