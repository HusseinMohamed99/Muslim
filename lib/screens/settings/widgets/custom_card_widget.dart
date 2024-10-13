part of './../../../core/helpers/export_manager/export_manager.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key,
      required this.settingsProvider,
      required this.function,
      required this.titleText,
      required this.iconData});
  final SettingsProvider settingsProvider;
  final VoidCallback function;
  final String titleText;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: settingsProvider.isDarkMode()
          ? ThemeApp.darkPrimary
          : ThemeApp.lightPrimary,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: InkWell(
          onTap: function,
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ),
              const Space(
                width: 10,
                height: 0,
              ),
              Text(
                titleText,
                style: settingsProvider.currentLanguage == 'en'
                    ? Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 25.sp),
                          fontWeight: FontWeight.w600,
                        )
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 25.sp),
                          fontWeight: FontWeight.w600,
                        ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_circle_down_sharp,
                color: Colors.white,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
