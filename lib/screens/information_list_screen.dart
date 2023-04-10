import 'package:flutter/material.dart';

import '../components/information_card.dart';

class InformationListScreen extends StatelessWidget {
  final String title;
  final String listLabel;
  final bool isTeacherList;

  const InformationListScreen(
      {Key? key,
      required this.title,
      required this.listLabel,
      required this.isTeacherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Widget> mockTeacherList = [
      InformationCard(
        title: 'Renzo Mesquita',
        subtitle: 'renzo@inatel.br',
      ),
      InformationCard(
        title: 'Chris Lima',
        subtitle: 'chris@inatel.br',
      ),
      InformationCard(
        title: 'Marcelo',
        subtitle: 'marcelo@inatel.br',
      ),
    ];
    const List<Widget> mockCollegePhones = [
      InformationCard(
        title: 'CRA',
        subtitle: '(35) 3921-3123',
      ),
      InformationCard(
        title: 'Tesouraria',
        subtitle: '(35) 3921-3124',
      ),
      InformationCard(
        title: 'RH',
        subtitle: '(35) 3921-3125',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listLabel,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Expanded(
              child: ListView(
                children: isTeacherList ? mockTeacherList : mockCollegePhones,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
