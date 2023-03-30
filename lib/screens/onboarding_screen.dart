import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/themes/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../components/onboarding/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  List<Widget> pages = [
    OnboardingPage(
      icon: Icons.calendar_month,
      title: 'Cronograma\nAcadêmico',
      description: 'Veja disciplinas matriculadas e quadro de horários',
    ),
    OnboardingPage(
      icon: Icons.chrome_reader_mode,
      title: 'Desempenho no\nAcadêmico',
      description: 'Veja suas notas e simule suas médias.',
    ),
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: pages,
            ),
          ),
          PageViewDotIndicator(
            currentItem: _currentPage,
            count: pages.length,
            selectedColor: lightColorScheme.primary,
            unselectedColor: lightColorScheme.secondaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: ActionButton(
              text: 'Continuar',
              onPressed: () {
                if (_currentPage == pages.length - 1) {
                  Navigator.pop(context);
                } else {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              color: _currentPage == pages.length - 1
                  ? lightColorScheme.primary
                  : null,
              textColor: _currentPage == pages.length - 1
                  ? lightColorScheme.onPrimary
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
