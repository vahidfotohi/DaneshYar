import 'package:daneshyar/core/routes/test.dart';
import 'package:flutter/material.dart';
import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/utils/keyboard.dart';
import 'package:flutter_svg/svg.dart';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../features/home/view/home_screen.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      const Setting(),
      const Con(),
      const Fav(),
      const Cor(),
      const HomeScreen(),

      /// TODO complete late
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final theme = Theme.of(context);
    final themeData = theme.textTheme;
    final themeColor = theme.colorScheme;
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/settings.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            themeColor.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        title: "تنظیمات",
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey,
        ),
        activeColorPrimary: AppColors.primary,

        inactiveIcon: SvgPicture.asset(
          'assets/icons/settings.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/conversation.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            themeColor.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        // title: "Favorites",
        activeColorPrimary: AppColors.primary,
        title: "گفتگو",
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey,
        ),

        inactiveIcon: SvgPicture.asset(
          'assets/icons/conversation.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/favorite.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            themeColor.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        // title: "Booking",
        activeColorPrimary: AppColors.primary,
        title: "علاقه‌مندی",
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey,
        ),

        inactiveIcon: SvgPicture.asset(
          'assets/icons/favorite.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/courses.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            themeColor.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        // title: "Profile",
        activeColorPrimary: AppColors.primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey,
        ),

        title: "دوره ها",
        inactiveIcon: SvgPicture.asset(
          'assets/icons/courses.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/home.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: Colors.grey,
        title: "خانه",
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey,
        ),

        inactiveIcon: SvgPicture.asset(
          'assets/icons/home.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 4);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      onItemSelected: (index) {
        unfocusEditors(context);

        // if (index != 2) {
        //   // BookingScreen.bookingScreenKey.currentState?.resetForm();
        //   /// TODO complete late
        // }
      },
      screens: _buildScreens(),
      context,
      controller: _controller,
      items: _navBarsItems(),
      padding: const EdgeInsets.all(12),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      navBarStyle: NavBarStyle.style6,
      stateManagement: true,
      navBarHeight: 95,

      hideNavigationBarWhenKeyboardAppears: true,
      confineToSafeArea: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
