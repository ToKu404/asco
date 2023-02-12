import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/class_detail_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_class_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/practicum_assistant_page.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';

void showAdminCreatePracticumPage(
    {required BuildContext context, bool isEdit = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreatePracticumPage(isEdit: isEdit),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreatePracticumPage extends StatefulWidget {
  final bool isEdit;
  const CreatePracticumPage({super.key, required this.isEdit});

  @override
  State<CreatePracticumPage> createState() => _CreatePracticumPageState();
}

class _CreatePracticumPageState extends State<CreatePracticumPage> {
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
            Icons.close_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _onSubmit();
            },
            icon: const Icon(
              Icons.check_rounded,
              color: Palette.white,
            ),
          )
        ],
        title: Text(
          widget.isEdit ? 'Edit Data' : 'Tambah Data',
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
              'Badge',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              width: 58,
              height: 58,
              child: InkWellContainer(
                color: Colors.white,
                onTap: () {},
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                  ),
                ),
                border: Border.all(width: 1, style: BorderStyle.values[1]),
                radius: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InputTextField(controller: _courseController, title: 'Matakuliah'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Kontrak Kuliah',
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

  void _onSubmit() {}
}
