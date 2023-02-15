import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/assistance_page/class_student_page.dart';
import 'package:asco/src/presentations/features/admin/assistance_page/create_assistance_page.dart';
import 'package:flutter/material.dart';

void showAdminAssistanceGroupDetailPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AssistanceGroupDetailPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AssistanceGroupDetailPage extends StatelessWidget {
  const AssistanceGroupDetailPage({super.key});

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
              showAdminCreateAssistancePage(context: context, isEdit: true);
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppSize.getAppWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grup Asistensi',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      '4',
                      style: kTextTheme.headlineMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Asisten',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Eurico Devon',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
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
                    'Mahasiswa',
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
                        showAdminAssistanceStudentPage(context: context);
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
