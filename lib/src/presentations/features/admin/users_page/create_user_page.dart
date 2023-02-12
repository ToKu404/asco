import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/auth_service.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAdminCreateUserPage(
    {required BuildContext context, bool isEdit = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateUserPage(isEdit: isEdit),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateUserPage extends StatefulWidget {
  final bool isEdit;
  const CreateUserPage({super.key, required this.isEdit});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<String?> _batchNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _roleNotifier = ValueNotifier(null);

  final _listRole = [
    'Praktikan',
    'Asisten',
  ];
  final _listBatch = [
    for (int i = 0; i < 7; i++) (DateTime.now().year - i).toString(),
  ];

  @override
  void initState() {
    _batchNotifier.value = _listBatch.first;
    _roleNotifier.value = _listRole.first;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _batchNotifier.dispose();
    _roleNotifier.dispose();
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
            InputTextField(controller: _usernameController, title: 'Username'),
            const SizedBox(
              height: 16,
            ),
            InputTextField(
                controller: _fullnameController, title: 'Nama Lengkap'),
            const SizedBox(
              height: 16,
            ),
            InputDropdownField(
              selectItem: _batchNotifier,
              title: 'Angkatan',
              listItem: _listBatch,
            ),
            const SizedBox(
              height: 16,
            ),
            _buildRoleCheckBox(),
            const SizedBox(
              height: 16,
            ),
            InputTextField(controller: _passwordController, title: 'Password'),
          ],
        ),
      )),
    );
  }

  void _onSubmit() {
    final authProvider = Provider.of<AuthNotifier>(context, listen: false);

    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      authProvider.createUser(
        UserEntity(
          username: _usernameController.text,
          password: AuthService.hashPassword(_passwordController.text),
          roleId: _listRole.indexOf(_roleNotifier.value!) + 1,
        ),
      );
    }
  }

  Widget _buildRoleCheckBox() {
    return ValueListenableBuilder(
        valueListenable: _roleNotifier,
        builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Role',
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
                      child: CustomCheckBoxItem(
                    value: _listRole.first,
                    isActive: value == _listRole.first,
                    onTap: () => _roleNotifier.value = _listRole.first,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomCheckBoxItem(
                      value: _listRole.last,
                      isActive: value == _listRole.last,
                      onTap: () => _roleNotifier.value = _listRole.last,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

class CustomCheckBoxItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final String value;
  const CustomCheckBoxItem({
    required this.value,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Palette.white,
      onTap: onTap,
      border: Border.all(width: 1, color: Palette.black),
      radius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.purple80,
              ),
            ),
          ),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Palette.black,
              ),
              color: isActive ? Palette.purple60 : Palette.grey10,
            ),
            child: isActive
                ? const Center(
                    child: Icon(Icons.check_rounded,
                        color: Palette.white, size: 12),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
