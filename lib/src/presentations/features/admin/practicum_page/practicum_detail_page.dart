import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/class_detail_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_class_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/practicum_assistant_page.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAdminPracticumDetailPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PracticumDetailPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class PracticumDetailPage extends StatelessWidget {
  const PracticumDetailPage({super.key});

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
        actions: [
          IconButton(
            onPressed: () {
              showAdminCreatePracticumPage(context: context, isEdit: true);
            },
            icon: const Icon(
              Icons.edit_rounded,
              color: Palette.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          'Mata Kuliah',
                          style: kTextTheme.titleSmall?.copyWith(
                              color: Palette.blackPurple,
                              fontWeight: FontWeight.w400,
                              height: 1.2),
                        ),
                        Text(
                          'Basis Data',
                          style: kTextTheme.headlineMedium?.copyWith(
                            color: Palette.blackPurple,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    '2',
                    style: kTextTheme.titleSmall?.copyWith(
                      color: Palette.purple70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Kelas',
                    style: kTextTheme.titleSmall?.copyWith(
                      color: Palette.black,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Palette.purple70,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      onPressed: () {
                        showAdminCreateClassPage(context: context);
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              const PracticumClassCard(),
              const SizedBox(
                height: 8,
              ),
              const PracticumClassCard(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '5',
                    style: kTextTheme.titleSmall?.copyWith(
                      color: Palette.purple70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Asisten',
                    style: kTextTheme.titleSmall?.copyWith(
                      color: Palette.black,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Palette.purple70,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      onPressed: () {
                        showAdminPracticumAssistantPage(context: context);
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              const UserCard(),
              const SizedBox(
                height: 8,
              ),
              const UserCard(),
              const SizedBox(
                height: 8,
              ),
              const UserCard(),
              const SizedBox(
                height: 8,
              ),
              const UserCard(),
              const SizedBox(
                height: 8,
              ),
              const UserCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getAppWidth(context),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(AssetPath.getImage('avatar1.jpg')),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'H071191049',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple60,
                  ),
                ),
                Text(
                  'Ikhsan',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple80,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
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

class PracticumClassCard extends StatelessWidget {
  const PracticumClassCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {
        showAdminClassDetailPage(context: context);
      },
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basis Data',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple80,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'Kelas A',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Setiap Kamis 20.00 - 23.00',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      showAdminCreateClassPage(context: context, isEdit: true);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Palette.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Palette.white,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
