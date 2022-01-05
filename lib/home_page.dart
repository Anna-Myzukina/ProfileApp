///
///
/// Copyright (c) 2021 Razeware LLC
/// Permission is hereby granted, free of charge, to any person
/// obtaining a copy of this software and associated documentation
/// files (the "Software"), to deal in the Software without
/// restriction, including without limitation the rights to use,
/// copy, modify, merge, publish, distribute, sublicense, and/or
/// sell copies of the Software, and to permit persons to whom
/// the Software is furnished to do so, subject to the following
/// conditions:

/// The above copyright notice and this permission notice shall be
/// included in all copies or substantial portions of the Software.

/// Notwithstanding the foregoing, you may not use, copy, modify,
/// merge, publish, distribute, sublicense, create a derivative work,
/// and/or sell copies of the Software in any work that is designed,
/// intended, or marketed for pedagogical or instructional purposes
/// related to programming, coding, application development, or
/// information technology. Permission for such use, copying,
/// modification, merger, publication, distribution, sublicensing,
/// creation of derivative works, or sale is expressly withheld.

/// This project and source code may use libraries or frameworks
/// that are released under various Open-Source licenses. Use of
/// those libraries and frameworks are governed by their own
/// individual licenses.

/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
/// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
/// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
/// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
/// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
/// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
///

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_app/utils/widgets/dynamic_text_container.dart';
import 'package:profile_app/utils/widgets/our_button_widget.dart';
import 'package:profile_app/utils/widgets/our_dropdown_widget.dart';
import 'package:profile_app/utils/widgets/our_image_widget.dart';
import 'package:profile_app/utils/widgets/our_label_widget.dart';
import 'package:profile_app/utils/widgets/our_text_field_widget.dart';
import 'package:profile_app/utils/widgets/user_property_text_widget.dart';
import 'add_member_page.dart';

import 'utils/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _birthDateController;

  final String _familyMemberNames = '';
  final String _friendNames = '';
  String _dropdownValue = ProjectConst.FEMALE;
  String _genderImage = ProjectConst.FEMALE_IMAGE;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _birthDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OurImageWidget(_genderImage),
            OurTextFieldWidget(_nameController, ProjectConst.NAME),
            OurTextFieldWidget(_surnameController, ProjectConst.SURNAME),
            OurTextFieldWidget(_birthDateController, ProjectConst.BIRTH_DATE),
            OurDropDownWidget(
                ProjectConst.FEMALE,
                [ProjectConst.MALE, ProjectConst.FEMALE, ProjectConst.OTHER],
                _onGenderSelected),
            OurLabelWidget(ProjectConst.FAMILY_MEMEBERS),
            DynamicTextWidget(_familyMemberNames.isEmpty
                ? ProjectConst.NO_FAMILY
                : _familyMemberNames),
            OurLabelWidget(ProjectConst.FRIENDS),
            DynamicTextWidget(
                _friendNames.isEmpty ? ProjectConst.NO_FRIENDS : _friendNames),
            IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const AddMemberPage()))
                      .then((value) => {});
                }),
          ],
        )),
        OurButtonWidget(_displayUserInfo, ProjectConst.SAVE_PREVIEW)
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _birthDateController.dispose();
  }

  void _onGenderSelected(String newValue) {
    setState(() {
      _dropdownValue = newValue;
      if (_dropdownValue.toLowerCase() == ProjectConst.MALE) {
        _genderImage = ProjectConst.MALE_IMAGE;
      } else if (_dropdownValue.toLowerCase() == ProjectConst.FEMALE) {
        _genderImage = ProjectConst.FEMALE_IMAGE;
      } else {
        _genderImage = ProjectConst.FEMALE_MALE_IMAGE;
      }
    });
  }

  void _onClearClicked() {
    Navigator.pop(context);
  }

  void _displayUserInfo() {
    _showPreview();
  }

  void _updateNames () { 
  setState (() { 
    _friendNames = DataManager.getFriendNames (); 
    _familyMemberNames = DataManager.getFamilyMemberNames (); 
  }); 
}

  void _showPreview() {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ProjectConst.value12)),
              //this right here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: OurImageWidget(_genderImage),
                  ),
                  // add user property
                  UserTextWidget('${ProjectConst.NAME}:'),
                  // add user property
                  UserTextWidget('${ProjectConst.SURNAME}:'),
                  // add user property
                  UserTextWidget('${ProjectConst.GENDER}:'),
                  // add user property
                  UserTextWidget('${ProjectConst.BIRTH_DATE_LABEL}:'),
                  OurLabelWidget(ProjectConst.PERSONS),
                  Container(
                    height: ProjectConst.value80,
                    // add user property
                    child: ListView.builder(
                        padding: const EdgeInsets.all(ProjectConst.value8),
                        itemCount: 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(child: Text(''));
                        }),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: OurButtonWidget(
                          _onClearClicked, ProjectConst.UPLOAD_CLEAR)),
                ],
              ),
            ));
  }
}
