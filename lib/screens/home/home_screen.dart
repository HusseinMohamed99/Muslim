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
                  voidCallback: () {},
                ),
                CustomCardItem(
                  imageIcon: AssetsPath.assetsImagesMoon,
                  title: 'اذكار المساء',
                  voidCallback: () {},
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
