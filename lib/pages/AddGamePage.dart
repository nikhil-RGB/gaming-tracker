import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

XFile? image;

class AddGamePage extends StatefulWidget {
  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Text(
                    "New Game",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Gap(200),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            buildNameField(),
            buildDescriptionField(),
            Gap(10),
            buildImageContainer(),
            const Gap(5),
            _clickToLoad(),
            const Gap(5),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  //Click here to load image text
  Widget _clickToLoad() {
    return GestureDetector(
      //on user tap.
      onTap: () {
        setState(() {});
      },
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Click here to load selected image",
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  //builds the name field
  Widget buildNameField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name of the game",
            style: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {});
            },
            controller: _name,
            maxLength: 40,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter Name here",
            ),
          ),
        ],
      ),
    );
  }

  //Builds the description field
  Widget buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description of the game",
            style: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {});
            },
            controller: _description,
            maxLines: 3,
            maxLength: 90,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter Description here",
            ),
          ),
        ],
      ),
    );
  }

  //Build an image container
  Widget buildImageContainer() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            image = null;
            _pickImage();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 54, 54),
            border: Border.all(
              color: Colors.redAccent,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: (image != null)
              ? SizedBox(
                  width: 460,
                  height: 270,
                  child: Image.file(File(image!.path)),
                )
              : const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload_outlined),
                        SizedBox(height: 20.0),
                        Text(
                          "Upload image from gallery",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Gap(15),
                        Text(
                          "Supported formats: .jpg .png",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // Construct a submit button to save game info
  Widget buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: isDataValid() ? Colors.redAccent : Colors.grey,
          ),
          onPressed: isDataValid()
              ? () {
                  save();
                  Fluttertoast.showToast(
                      msg: "Entry Saved!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 41, 40, 40),
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.of(context).pop();
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "Add",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )),
    );
  }

  //Checks whether the inputted data is valid or not
  bool isDataValid() {
    return !((_name.text.replaceAll(" ", "")).isEmpty ||
        _description.text.replaceAll(" ", "").isEmpty ||
        image == null);
  }

  //TO-DO:Implement data persistence via hive boxes or Json Serialization
  void save() {
    GameDataModel model = GameDataModel(
        game_name: _name.text,
        description: _description.text,
        image_path: image!.path);
    String data = jsonEncode(model.toJson());
    File gamefile = File("${main_dir_path}/Games/${model.game_name}.txt");
    gamefile.createSync();
    gamefile.writeAsStringSync(data);
    Logger().w("$data\n${model.game_name}");

    image = null;
  }

  //Pick image from gallery
  Future _pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  //retrieves an image which might have been lost before
  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    try {
      if (files != null) {
        image = files[0];
      }
    } catch (response) {
      Fluttertoast.showToast(
          msg: "An error ocurred!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 41, 40, 40),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
