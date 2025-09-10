import 'package:daneshyar/core/routes/test.dart';
import 'package:flutter/material.dart';
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
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // استایل متن برای آیتم‌های نوار ناوبری
    final navBarTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: colorScheme.primaryFixed,
    );

    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/settings.svg',
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/settings.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.onSurfaceVariant, // استفاده از رنگ تم
            BlendMode.srcIn,
          ),
        ),
        title: "تنظیمات",
        textStyle: navBarTextStyle,
        activeColorPrimary: colorScheme.primaryFixed,
        inactiveColorPrimary: colorScheme.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/conversation.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/conversation.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.onSurfaceVariant, // استفاده از رنگ تم
            BlendMode.srcIn,
          ),
        ),
        title: "گفتگو",
        textStyle: navBarTextStyle,
        activeColorPrimary: colorScheme.primaryFixed,
        inactiveColorPrimary: colorScheme.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/favorite.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/favorite.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.onSurfaceVariant, // استفاده از رنگ تم
            BlendMode.srcIn,
          ),
        ),
        title: "علاقه‌مندی",
        textStyle: navBarTextStyle,
        activeColorPrimary: colorScheme.primaryFixed,
        inactiveColorPrimary: colorScheme.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/courses.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/courses.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.onSurfaceVariant, // استفاده از رنگ تم
            BlendMode.srcIn,
          ),
        ),
        title: "دوره ها",
        textStyle: navBarTextStyle,
        activeColorPrimary: colorScheme.primaryFixed,
        inactiveColorPrimary: colorScheme.onSurfaceVariant,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/home.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.primaryFixed,
            BlendMode.srcIn,
          ),
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/home.svg',
          colorFilter: ColorFilter.mode(
            colorScheme.onSurfaceVariant, // استفاده از رنگ تم
            BlendMode.srcIn,
          ),
        ),
        title: "خانه",
        textStyle: navBarTextStyle,
        activeColorPrimary: colorScheme.primaryFixed,
        inactiveColorPrimary: colorScheme.onSurfaceVariant,
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
      },
      screens: _buildScreens(),
      context,
      controller: _controller,
      items: _navBarsItems(),
      padding: const EdgeInsets.all(12),
      backgroundColor: Theme.of(context).colorScheme.surface,
      // استفاده از رنگ تم
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
