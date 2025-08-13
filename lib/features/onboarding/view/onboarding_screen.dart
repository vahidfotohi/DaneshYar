import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Expanded(
              child: Image.asset("assets/images/onboarding/Image_1.png"),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headlineLarge,
                children: [
                  const TextSpan(text: 'برترین '),
                  TextSpan(
                    text: "دوره های آمــــــوزشی ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  const TextSpan(text: "برای رشد شما مهیا شده است."),
                ],
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              "تمام اتفاقات بزرگ زندگی شما،از کوچکترین رفتارهای روزانه شکل می گیرد.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 54),
            SizedBox(

              width: double.infinity,
              child: ElevatedButton(

                onPressed: () => _completeOnboarding(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: Text("اکنون شروع کنید"),
                ),
              ),
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
  
  Future<void> _completeOnboarding(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    if(context.mounted){
      Navigator.pushReplacementNamed(context, "/login");

    }
  }
}
