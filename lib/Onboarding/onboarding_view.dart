import 'package:flutter/material.dart';
import 'package:gvagoo1/Onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wrapper.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final PageController _pageController = PageController(); // ✅ Fixed Naming
  bool isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose(); // ✅ Dispose to prevent memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Skip Button (Top Right Corner)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: TextButton(
              onPressed: () => _pageController.jumpToPage(controller.items.length - 1),
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),

      // ✅ Main Onboarding Content
      body: Stack(
        alignment: Alignment.center,
        children: [
          // PageView for Onboarding Screens
          PageView.builder(
            itemCount: controller.items.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == controller.items.length - 1;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image, height: 300),
                  const SizedBox(height: 20),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.items[index].descriptions,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),

          // ✅ Fixed Page Indicator
          Positioned(
            bottom: 100,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: controller.items.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.blueAccent,
                dotColor: Colors.grey,
                expansionFactor: 1.3,
              ),
            ),
          ),
        ],
      ),

      // ✅ Bottom Section for Navigation Buttons
      bottomSheet: Container(
        height: 90,
        color: Colors.white, // Outer background fix
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: isLastPage
            ? getStartedButton() // Show "Get Started" button on last page
            : nextButton(), // Show "Next" button on other pages
      ),
    );
  }

  // ✅ Next Button for Non-Last Pages
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () => _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        "Next",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  // ✅ "Get Started" Button for Last Page
  Widget getStartedButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blueAccent,
      ),
      child: TextButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("onboarding", true);

          // ✅ Navigate to Wrapper after onboarding
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Wrapper(),
            ),
          );
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
