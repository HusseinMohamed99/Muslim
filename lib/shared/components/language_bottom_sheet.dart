part of './../../core/helpers/export_manager/export_manager.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode();
    final color = isDarkMode ? const Color(0xff141922) : Colors.white;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLanguageOption(
            context,
            languageCode: 'en',
            title: AppLocalizations.of(context)!.english,
            isSelected: settingsProvider.currentLanguage == 'en',
            onTap: () => settingsProvider.changeLanguage('en'),
          ),
          const Space(height: 12, width: 0),
          _buildLanguageOption(
            context,
            languageCode: 'ar',
            title: AppLocalizations.of(context)!.arabic,
            isSelected: settingsProvider.currentLanguage == 'ar',
            onTap: () => settingsProvider.changeLanguage('ar'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String languageCode,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: isSelected
          ? _getSelectedItem(context, title)
          : _getUnselectedItem(context, title),
    );
  }

  Widget _getSelectedItem(BuildContext context, String title) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final textColor =
        settingsProvider.isDarkMode() ? ThemeApp.yellow : ThemeApp.lightPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: textColor,
                fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
              ),
        ),
        Icon(
          FontAwesomeIcons.circleCheck,
          color: textColor,
          size: 24.sp,
        ),
      ],
    );
  }

  Widget _getUnselectedItem(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
          ),
    );
  }
}
