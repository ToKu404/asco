import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/role_map.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:asco/src/presentations/widgets/input_field/field_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final ValueNotifier<String?> _batchNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _roleNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _genderNotifier = ValueNotifier(null);

  final _listRole = [
    'Praktikan',
    'Asisten',
  ];
  final _listGender = [
    'Laki-laki',
    'Perempuan',
  ];
  final _listBatch = [
    for (int i = 0; i < 7; i++) (DateTime.now().year - i).toString(),
  ];

  @override
  void initState() {
    _batchNotifier.value = _listBatch.first;
    _roleNotifier.value = _listRole.first;
    _genderNotifier.value = _listGender.first;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _instagramController.dispose();
    _githubController.dispose();
    _batchNotifier.dispose();
    _roleNotifier.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final userNotifier = context.watch<AuthNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (authNotifier.createUserState == RequestState.success &&
          userNotifier.createUserState == RequestState.success) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        authNotifier.reset();
        userNotifier.reset();
      }
    });

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldTitle(
                title: 'Profile Photo',
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: InkWellContainer(
                  color: Colors.white,
                  onTap: () {},
                  border: Border.all(width: 1, style: BorderStyle.values[1]),
                  radius: 12,
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                controller: _usernameController,
                title: 'Username',
                isRequired: true,
              ),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                  controller: _passwordController,
                  title: 'Password (Auto Generate)'),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                controller: _fullnameController,
                title: 'Nama Lengkap',
                isRequired: true,
                onEditingComplete: _nicknameController.text.trim().isEmpty
                    ? () {
                        _nicknameController.text =
                            UserService.nicknameGenerator(
                                _fullnameController.text);
                      }
                    : null,
              ),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                controller: _nicknameController,
                title: 'Nama Panggilan',
              ),
              const SizedBox(
                height: 16,
              ),
              InputDropdownField(
                selectItem: _batchNotifier,
                title: 'Angkatan',
                isRequired: true,
                listItem: _listBatch,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildGenderCheckBox(),
              const SizedBox(
                height: 16,
              ),
              _buildRoleCheckBox(),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                controller: _githubController,
                title: 'Github',
              ),
              const SizedBox(
                height: 16,
              ),
              InputTextField(
                controller: _instagramController,
                title: 'Instagram',
              ),
            ],
          ),
        ),
      )),
    );
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    final authProvider = Provider.of<AuthNotifier>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileNotifier>(context, listen: false);

    if (_formKey.currentState!.validate() &&
        _batchNotifier.value != null &&
        _genderNotifier.value != null &&
        _roleNotifier.value != null) {
      /// Create new user
      String password = '';
      if (_passwordController.text.isEmpty) {
        password = _usernameController.text;
      } else {
        password = _passwordController.text;
      }
      authProvider.createUser(
        UserEntity(
          username: _usernameController.text,
          password: UserService.hashPassword(password),
          roleId: _listRole.indexOf(_roleNotifier.value!) + 1,
        ),
      );

      ///Create new profile
      String nickName = '';
      if (_nicknameController.text.isEmpty) {
        nickName = UserService.nicknameGenerator(_fullnameController.text);
      } else {
        nickName = _nicknameController.text;
      }
      profileProvider.createProfile(
        UserProfileEntity(
          classOf: _batchNotifier.value,
          fullName: UserService.titleMaker(_fullnameController.text),
          gender: _genderNotifier.value,
          github: _githubController.text,
          instagram: _instagramController.text,
          nickName: UserService.titleMaker(nickName),
          profilePhoto: 'https://i.mydramalist.com/e3AQef.jpg',
          username: _usernameController.text,
          userRole: UserRoleEntity(
              id: RoleHelper.nameToId(_roleNotifier.value!),
              name: _roleNotifier.value!),
        ),
      );
    }
  }

  Widget _buildGenderCheckBox() {
    return ValueListenableBuilder(
        valueListenable: _genderNotifier,
        builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredFieldTitle(
                title: 'Jenis Kelamin',
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomCheckBoxItem(
                    value: 'L',
                    isActive: value == _listGender.first,
                    onTap: () => _genderNotifier.value = _listGender.first,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomCheckBoxItem(
                      value: 'P',
                      isActive: value == _listGender.last,
                      onTap: () => _genderNotifier.value = _listGender.last,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget _buildRoleCheckBox() {
    return ValueListenableBuilder(
        valueListenable: _roleNotifier,
        builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredFieldTitle(
                title: 'Role',
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
