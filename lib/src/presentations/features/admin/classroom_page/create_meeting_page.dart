import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';

void showAdminCreateMeetingPage(
    {required BuildContext context, bool isEdit = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateMeetingPage(isEdit: isEdit),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateMeetingPage extends StatefulWidget {
  final bool isEdit;
  const CreateMeetingPage({super.key, required this.isEdit});

  @override
  State<CreateMeetingPage> createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final ValueNotifier<String?> _assistant1 = ValueNotifier(null);
  final ValueNotifier<String?> _assistant2 = ValueNotifier(null);

  final _listAssistant = [
    'Richard',
    'Ucup',
    'Alip',
    'Sony',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _topicController.dispose();
    _dateController.dispose();
    _assistant1.dispose();
    _assistant2.dispose();
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
            InputTextField(controller: _topicController, title: 'Materi'),
            const SizedBox(
              height: 16,
            ),
            InputTextField(
                controller: _dateController, title: 'Tanggal Pertemuan'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Modul',
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
            const SizedBox(
              height: 16,
            ),
            InputDropdownField(
              selectItem: _assistant1,
              title: 'Pemateri',
              listItem: _listAssistant,
            ),
            const SizedBox(
              height: 16,
            ),
            InputDropdownField(
              selectItem: _assistant2,
              title: 'Pendamping',
              listItem: _listAssistant,
            ),
          ],
        ),
      )),
    );
  }

  void _onSubmit() {}
}
