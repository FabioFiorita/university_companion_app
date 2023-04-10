import 'package:c317_mobile/components/action_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).disabledColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: ActionButton(
              text: 'Continuar',
              onPressed: () {
                if (_currentPage == pages.length - 1) {
                  context.go('/');
                } else {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              color: _currentPage == pages.length - 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor,
              textColor: _currentPage == pages.length - 1
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).canvasColor,
            ),
          )
        ],
      ),
    );
  }
}
