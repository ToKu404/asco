import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AssistantValueRecap extends StatelessWidget {
  const AssistantValueRecap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Rekap Nilai',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Nilai Akhir',
                        style: kTextTheme.bodyLarge?.copyWith(
                          color: Palette.purple80,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    CircularPercentIndicator(
                      animation: true,
                      reverse: true,
                      animationDuration: 1500,
                      curve: Curves.easeOut,
                      radius: 60,
                      lineWidth: 6,
                      percent: .78,
                      progressColor: Palette.purple60,
                      backgroundColor: Palette.purple10,
                      backgroundWidth: 30,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'A',
                              style: kTextTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '97',
                              style: kTextTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.orange10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'NILAI UJIAN LAB',
                              style: kTextTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Palette.greyDark,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 4,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Palette.orange60,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                ),
                                Flexible(
                                  child: Text(
                                    '80.2',
                                    style: kTextTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CardValue(
                            text: 'NILAI QUIZ',
                            value: 80.2,
                            color1: Palette.violet10,
                            color2: Palette.violet60,
                          ),
                          SizedBox(width: 12),
                          CardValue(
                            text: 'NILAI ASISTENSI',
                            value: 80.2,
                            color1: Palette.purple10,
                            color2: Palette.purple80,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(child: Text('Nilai Quiz')),
                        Tab(child: Text('Nilai Asistensi')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Palette.white,
                      ),
                      padding: const EdgeInsets.all(18),
                      child: const TabBarView(
                        children: [
                          ListValue(),
                          ListValue(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListValue extends StatelessWidget {
  const ListValue({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          minLeadingWidth: 6,
          leading: Container(
            decoration: BoxDecoration(
              color: Palette.purple70,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(18),
            child: Text(
              '${index + 1}',
              style: kTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Palette.white,
              ),
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  'Tipe Data dan Variabel',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple40,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  '70.0',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple80,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            '"bagus namun terlambat"',
            style: kTextTheme.bodySmall,
          ),
        );
      },
      separatorBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: 6),
        child: const Divider(
          height: 2,
          color: Palette.grey10,
        ),
      ),
      itemCount: 10,
    );
  }
}

class CardValue extends StatelessWidget {
  const CardValue({
    super.key,
    required this.text,
    required this.value,
    required this.color1,
    required this.color2,
  });

  final String text;
  final double value;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width / 2 - 55,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              style: kTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w300,
                color: Palette.greyDark,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4,
                  height: 26,
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                ),
                Flexible(
                  child: Text(
                    '$value',
                    style: kTextTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
