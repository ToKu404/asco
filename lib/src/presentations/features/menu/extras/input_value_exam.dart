import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/search_field.dart';
import 'package:asco/src/presentations/widgets/avatar.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InputValueExam extends StatelessWidget {
  const InputValueExam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Input Nilai Ujian',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.purple60,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Total Poin',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  color: Palette.white,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${100}',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SearchField(
                      text: 'cari nama atau nim',
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: MasonryGridView.builder(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                crossAxisSpacing: 12,
                itemBuilder: (context, index) => const GridCard(),
                itemCount: 2,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.3,
              minChildSize: 0.1,
              initialChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Palette.purple100,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Muh. Ikhsan',
                          style: kTextTheme.bodyLarge?.copyWith(
                            color: Palette.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'H071191049',
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: Palette.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            flex: 7,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                filled: true,
                                hintText: 'Tambah Poin',
                                hintStyle: kTextTheme.bodyMedium?.copyWith(
                                  color: Palette.greyDark,
                                ),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Palette.blackPurple),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Palette.purple80),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: InkWellContainer(
                              color: Palette.white,
                              onTap: () {},
                              radius: 12,
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.arrow_upward,
                                color: Palette.purple60,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  const GridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        border: Border.all(color: Palette.purple80),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Palette.purple80,
            spreadRadius: 2,
            offset: Offset.fromDirection(20, 3.5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            '${27}',
                            style: kTextTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.purple80,
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
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            '${30}',
                            style: kTextTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.purple80,
                            ),
                          ),
                          Text(
                            'Maks',
                            style: kTextTheme.bodySmall?.copyWith(
                              color: Palette.purple60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 3000,
                curve: Curves.easeOut,
                radius: 35,
                reverse: true,
                lineWidth: 10,
                percent: .78,
                progressColor: Palette.purple60,
                backgroundColor: Colors.transparent,
                circularStrokeCap: CircularStrokeCap.round,
                center: Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.purple80,
                  ),
                  child: Center(
                    child: Text(
                      '78.0',
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
            children: [
              const Flexible(
                child: Avatar(
                  imageAsset: 'avatar1.jpg',
                  radius: 18,
                  color: Palette.purple80,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'H071191049',
                        style: kTextTheme.bodySmall?.copyWith(
                          color: Palette.purple60,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Muh. Ikhsan',
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.purple80,
                          fontWeight: FontWeight.w600,
                        ),
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
