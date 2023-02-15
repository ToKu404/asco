import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/avatar.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class LabExamPage extends StatelessWidget {
  const LabExamPage({super.key});

  static List<Widget> session = [
    Text(
      'Sesi 1 : 08.00 - 10.00',
      style: kTextTheme.bodyMedium,
    ),
    Text(
      'Sesi 2 : 11.00 - 13.00',
      style: kTextTheme.bodyMedium,
    ),
    Text(
      'Sesi 3 : 14.00 - 16.00',
      style: kTextTheme.bodyMedium,
    ),
    Text(
      'Sesi 4 : 16.00 - 18.00',
      style: kTextTheme.bodyMedium,
    ),
  ];
  static List<Widget> rules = [
    Text(
      '- Peserta wajib membawa laptop sendiri',
      style: kTextTheme.bodyMedium,
    ),
    Text(
      '- Hadir tepat waktu',
      style: kTextTheme.bodyMedium,
    ),
    Text(
      '- Jika ketahuan menyontek nilai dikali 0',
      style: kTextTheme.bodyMedium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Ujian Lab',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.plum70,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Text(
                            'Edit Info',
                            textAlign: TextAlign.center,
                            style: kTextTheme.bodyMedium?.copyWith(
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.purple60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Text(
                            'Input Nilai',
                            textAlign: TextAlign.center,
                            style: kTextTheme.bodyMedium?.copyWith(
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(12),
                child: ExpandablePanel(
                  header: Text(
                    'Pengumuman',
                    style: kTextTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    iconColor: Palette.black,
                  ),
                  expanded: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'Ujian lab diadakan 4 sesi',
                            style: kTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            children: session,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            'Ketentuan :',
                            style: kTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            children: rules,
                          ),
                        ),
                      ],
                    ),
                  ),
                  collapsed: Container(),
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: Text(
                  'Nilai Ujian Lab',
                  style: kTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemBuilder: (context, index) => const CardValue(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardValue extends StatelessWidget {
  const CardValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Avatar(imageAsset: 'avatar1.jpg', radius: 28),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                'H071191049',
                style: kTextTheme.bodyMedium?.copyWith(
                  color: Palette.purple60,
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Erwin',
                style: kTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Palette.purple60,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Kelas B',
                style: kTextTheme.bodySmall?.copyWith(
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${97}',
          style: kTextTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
