part of './../../core/helpers/export_manager/export_manager.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode();
    final backgroundColor = isDarkMode ? const Color(0xff141922) : Colors.white;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ).r,
      ),
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildThemeOption(
            title: AppLocalizations.of(context)!.light,
            isSelected: !isDarkMode,
            onTap: () => settingsProvider.changeTheme(ThemeMode.light),
          ),
          const Space(width: 0, height: 12),
          _buildThemeOption(
            title: AppLocalizations.of(context)!.dark,
            isSelected: isDarkMode,
            onTap: () => settingsProvider.changeTheme(ThemeMode.dark),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final color =
        settingsProvider.isDarkMode() ? ThemeApp.yellow : ThemeApp.lightPrimary;

    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isSelected ? color : null,
                  fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
                ),
          ),
          if (isSelected)
            Icon(
              FontAwesomeIcons.circleCheck,
              color: color,
              size: 24.sp,
            ),
        ],
      ),
    );
  }
}
