import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

void showAdminLabRulePage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LabRulePage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class LabRulePage extends StatefulWidget {
  const LabRulePage({super.key});

  @override
  State<LabRulePage> createState() => _LabRulePageState();
}

class _LabRulePageState extends State<LabRulePage> {
  final TextEditingController _courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _courseController.dispose();

    super.dispose();
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
            Icons.arrow_back_ios_rounded,
            color: Palette.white,
          ),
        ),
        title: Text(
          'Data Tambahan Laboratorium',
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File Tata Tertib',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.azure40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.auto_stories_outlined,
                      size: 20,
                      color: Palette.white,
                    ),
                    label: Text(
                      'Tampilkan',
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Palette.purple70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.file_upload_rounded,
                    color: Palette.white,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Palette.plum40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Palette.white,
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
