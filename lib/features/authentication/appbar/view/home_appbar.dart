import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../authentication/user/provider/user_provider.dart';
import '../provider/appbar_provider.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(userProvider).user;
    final appbarState = ref.watch(appbarViewmodelProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryFixed.withValues(
          alpha: 0.85,
          blue: 100,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      width: double.infinity,


      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [

          Positioned(
            bottom: 0,
            left: -5,
            child: Image.asset(
              "assets/images/home/Pattern1.png",
              color: Colors.black,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -50,
            right: -20,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(-28/ 360),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/home/Pattern2.png",
                color: Colors.black,
                width: 250,
                height: 250,
                fit: BoxFit.contain,

              ),
            ),
          ),


          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryFixedDim.withValues(
                          alpha: 0.6,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                          if (appbarState.hasNotifications)
                            Positioned(
                              top: 15,
                              left: 23,
                              child: Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "سلام ${user?.fullName ?? "کاربر"} 👋",
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "فقط کافیه که شروع کنی...",
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                TextField(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "جستجو کن ....",
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                    hintTextDirection: TextDirection.rtl,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/searchIcon.svg",
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.primaryFixed,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
