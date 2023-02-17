import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/widgets/avatar.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/search_field.dart';

class AssistantLaboratoryQuizValueInputPage extends StatelessWidget {
  const AssistantLaboratoryQuizValueInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              centerTitle: true,
              title: const Text('Input Nilai Quiz'),
              titleTextStyle: kTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Palette.white,
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Palette.white,
                  size: 30,
                ),
                tooltip: 'Back',
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: const BottomAppBar(),
              shadowColor: Palette.greyDark,
              backgroundColor: Palette.purple80,
            ),
          ];
        },
        body: MasonryGridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 24,
          crossAxisSpacing: 16,
          itemBuilder: (_, i) => StudentQuizValueCard(student: students[i]),
          itemCount: students.length,
        ),
      ),
    );
  }
}

class BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: preferredSize.height,
      color: Palette.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: <Color>[
                  Palette.purple60,
                  Palette.purple80,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Total Poin',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    '100',
                    style: kTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SearchField(
            text: 'Cari nama atau nim',
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150); // default is 56.0
}

class StudentQuizValueCard extends StatelessWidget {
  final Student student;

  const StudentQuizValueCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      radius: 12,
      color: Palette.white,
      padding: const EdgeInsets.all(12),
      border: Border.all(color: Palette.purple80),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2,
          color: Palette.purple80,
          offset: Offset.fromDirection(20, 3.5),
        ),
      ],
      onTap: () => showBottomSheet(
        context: context,
        builder: (context) => CustomBottomSheet(student: student),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      children: <Text>[
                        Text(
                          '27',
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple80,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Poin',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Text>[
                        Text(
                          '30',
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple80,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Maks.',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                curve: Curves.easeOut,
                radius: 35,
                reverse: true,
                lineWidth: 8,
                percent: .7,
                progressColor: Palette.purple60,
                backgroundColor: Colors.transparent,
                circularStrokeCap: CircularStrokeCap.round,
                center: Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.purple80,
                  ),
                  child: Center(
                    child: Text(
                      '70.0',
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Avatar(
                imageAsset: 'avatar${student.id}.jpg',
                radius: 18,
                color: Palette.purple80,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Text>[
                    Text(
                      student.nim,
                      style: kTextTheme.bodySmall?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    Text(
                      student.name,
                      style: kTextTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final Student student;

  const CustomBottomSheet({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Palette.purple100,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Palette.grey50,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            student.name,
            style: kTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Palette.white,
            ),
          ),
          Text(
            student.nim,
            style: kTextTheme.bodyLarge?.copyWith(
              color: Palette.grey,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.purple100,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          bottom: 15,
                        ),
                        border: InputBorder.none,
                        hintText: 'Tambah Poin',
                        hintStyle: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Palette.grey50,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Palette.purple60,
                    size: 20,
                  ),
                  tooltip: 'Submit',
                  style: IconButton.styleFrom(
                    backgroundColor: Palette.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
