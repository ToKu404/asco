import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/assistance_page/assistance_page.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showAdminAssistancePracticumPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminAssistancePracticumPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminAssistancePracticumPage extends StatefulWidget {
  const AdminAssistancePracticumPage({super.key});

  @override
  State<AdminAssistancePracticumPage> createState() =>
      _AdminAssistancePracticumPageState();
}

class _AdminAssistancePracticumPageState
    extends State<AdminAssistancePracticumPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
          'Data Asistensi',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
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
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  PracticumCard(),
                  SizedBox(
                    height: 8,
                  ),
                  PracticumCard(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class PracticumCard extends StatelessWidget {
  const PracticumCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {
        showAdminAssistancePage(context: context);
      },
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
                    'Pemrograman Mobile',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '10 Grup Asistensi',
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
