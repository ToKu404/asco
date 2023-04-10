import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/presentations/features/admin/control_card_page/control_card.dart';
import 'package:asco/src/presentations/providers/control_card_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminListControlCardPage({
  required BuildContext context,
  required String studentId,
  required String studentName,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminListControlCardPage(
        studentId: studentId,
        studentName: studentName,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminListControlCardPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const AdminListControlCardPage({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<AdminListControlCardPage> createState() =>
      _AdminListControlCardPageState();
}

class _AdminListControlCardPageState extends State<AdminListControlCardPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ControlCardNotifier>(context, listen: false)
          .fetch(studentId: widget.studentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Palette.white,
          ),
        ),
        title: Text(
          "Kartu Kontrol ${widget.studentName}",
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  hintText: 'Cari nim atau nama lengkap',
                  hintStyle:
                      kTextTheme.bodyLarge?.copyWith(color: Palette.disable),
                  filled: true,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          AssetPath.getIcon('search_outlined.svg'),
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
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Builder(builder: (context) {
                final ccNotifier = context.watch<ControlCardNotifier>();

                // Todo : Add Shimmer
                if (ccNotifier.isLoadingState('find')) {
                  return const SizedBox.shrink();
                } else if (ccNotifier.isErrorState('find')) {
                  return const SizedBox.shrink();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16 + 65,
                  ),
                  itemBuilder: (context, index) {
                    final cardEntity = ccNotifier.listData[index];
                    return buildControlCard(context, cardEntity);
                  },
                  itemCount: ccNotifier.listData.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  ControlCard buildControlCard(
      BuildContext context, ControlCardEntity cardEntity) {
    return ControlCard(
      controlCardEntity: cardEntity,
      hasTrailing: true,
      trailing: AssistanceStatusBadge(),
      onTap: false ? null : () {},
    );
  }
}
