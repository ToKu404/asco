import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AdminAllPracticumSection extends StatefulWidget {
  final VoidCallback Function(PracticumEntity pr) onCardTap;
  const AdminAllPracticumSection({super.key, required this.onCardTap});

  @override
  State<AdminAllPracticumSection> createState() =>
      _AdminAllPracticumSectionState();
}

class _AdminAllPracticumSectionState extends State<AdminAllPracticumSection> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<PracticumNotifier>(context, listen: false)..fetch(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: searchController,
            onChanged: (value) {},
            keyboardType: TextInputType.text,
            style: kTextTheme.bodyLarge?.copyWith(
              color: Palette.blackPurple,
            ),
            cursorColor: Palette.blackPurple,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              hintText: 'Cari nama praktikum',
              hintStyle: kTextTheme.bodyLarge?.copyWith(color: Palette.disable),
              filled: true,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: SvgPicture.asset(
                      AssetPath.getIcons('search_outlined.svg'),
                      height: 18,
                      width: 18,
                    ),
                  ),
                ],
              ),
              prefixIconColor: Palette.blackPurple,
              fillColor: Palette.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.blackPurple),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.blackPurple),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            final dataProvider = context.watch<PracticumNotifier>();

            // Todo : Add Shimmer
            if (dataProvider.isLoadingState('find')) {
              return const SizedBox.shrink();
            } else if (dataProvider.isErrorState('find')) {
              return const SizedBox.shrink();
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16 + 65,
              ),
              itemBuilder: (context, index) {
                return PracticumCard(
                  practicum: dataProvider.listData[index],
                  onTap: widget.onCardTap.call(dataProvider.listData[index]),
                );
              },
              itemCount: dataProvider.listData.length,
            );
          }),
        ),
      ],
    );
  }
}

class PracticumCard extends StatelessWidget {
  final VoidCallback onTap;
  final PracticumEntity practicum;
  const PracticumCard({
    super.key,
    required this.onTap,
    required this.practicum,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      onTap: onTap,
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                AssetPath.getVector('badge_android.svg'),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    practicum.course ?? '',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '0 Kelas',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
