import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:gaming_tracker/models/Preference.dart';
import 'package:gaming_tracker/pages/StatisticsPage.dart';
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
  final TextEditingController _CPU = TextEditingController(text: '0');
  final TextEditingController _GPU = TextEditingController(text: '0');
  late Preference settings;
  // ignore: prefer_final_fields
  List<bool> _selectedPerformance = List.generate(3, (index) => false)
    ..[0] = true;

  List<bool> _selectedFans = List.generate(3, (index) => false)..[0] = true;
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
            const Gap(10),
            buildImageContainer(),
            const Gap(5),
            _clickToLoad(),

            //Performance widgets start
            const Gap(20),
            preferences(),
            const Gap(10),
            //Performance Widgets end

            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  //Widget for fan and power preferences
  Widget preferences() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Preferred Fan/Power Settings",
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(13),
        const Text(
          "Select Power Mode",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        performanceButtons(),
        const Gap(13),
        const Text(
          "Select Fan Mode",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        fanButtons(),
        const Gap(40),
        manualFanEntry(0),
        const Gap(9),
        manualFanEntry(1),
      ],
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
            decoration: InputDecoration(
                hintText: "Enter Name here",
                errorText: (gameExists())
                    ? "Duplicate names are not allowed"
                    : (_name.text == defaultGameSelection)
                        ? "'All Games' is an invalid name"
                        : null),
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
            color: const Color.fromARGB(255, 57, 54, 54),
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
        image == null ||
        gameExists() ||
        _name.text == defaultGameSelection);
  }

  bool gameExists() {
    return File("${main_dir_path}/Games/${_name.text}.txt").existsSync();
  }

  void save() {
    //Edit game data model to allow for preferences object
    Preference obj = Preference(
      CPU_FAN: int.parse(_CPU.text),
      GPU_FAN: int.parse(_GPU.text),
      fans: readFanMode(),
      pwr: readPowerMode(),
    ); //initialize preferences with selected options
    GameDataModel model = GameDataModel(
      game_name: _name.text,
      description: _description.text,
      image_path: image!.path,
      settings: obj,
    );
    String data = jsonEncode(model.toJson());
    File gamefile = File("${main_dir_path}/Games/${model.game_name}.txt");
    gamefile.createSync();
    gamefile.writeAsStringSync(data);
    // Logger().w("$data\n${model.game_name}");

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
          backgroundColor: const Color.fromARGB(255, 41, 40, 40),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget fanButtons() {
    return ToggleButtons(
        isSelected: _selectedFans,
        fillColor: const Color(0xFFFC5555),
        onPressed: (select_index) {
          _selectedFans = [false, false, false];
          setState(() {
            _selectedFans[select_index] = true;
          });
        },
        borderRadius: BorderRadius.circular(12),
        borderWidth: 3,
        selectedBorderColor: const Color(0xFFFC5555),
        children: [
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/fan_modes/auto_fans.png"),
          ),
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/fan_modes/max_fans.png"),
          ),
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/fan_modes/custom_fans.png"),
          ),
        ]);
  }

  //Performance buttons
  Widget performanceButtons() {
    return ToggleButtons(
        isSelected: _selectedPerformance,
        fillColor: const Color(0xFFFC5555),
        onPressed: (select_index) {
          _selectedPerformance = [false, false, false];
          setState(() {
            _selectedPerformance[select_index] = true;
          });
        },
        borderRadius: BorderRadius.circular(12),
        borderWidth: 3,
        selectedBorderColor: const Color(0xFFFC5555),
        children: [
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/power_modes/balanced.png"),
          ),
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/power_modes/performance.png"),
          ),
          SizedBox(
            height: 90,
            width: 105,
            child: Image.asset("assets/images/power_modes/turbo.png"),
          ),
        ]);
  }

  Widget manualFanEntry(int control) {
    bool isCPU = control == 0;
    return Center(
      child: Row(
        //start here
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isCPU ? "Avg CPU Fan Speed: " : "Avg GPU Fan Speed: ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          SizedBox(
            width: 60,
            height: 30,
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Color(0xFFFC5555)),
                ),
              ),
              controller: isCPU ? _CPU : _GPU,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          )
        ],
      ),
    );
  }

  //Parse and read power mode from toggle buttons
  PowerMode readPowerMode() {
    int control = _selectedPerformance.indexOf(true);
    switch (control) {
      case 0:
        return PowerMode.Balanced;
      case 1:
        return PowerMode.Performance;
      case 2:
        return PowerMode.Turbo;
      default:
        throw "Invalid Power State";
    }
  }

  //Parse and read Fan mode from toggle buttons:
  FanSpeed readFanMode() {
    int control = _selectedFans.indexOf(true);
    switch (control) {
      case 0:
        return FanSpeed.Auto;
      case 1:
        return FanSpeed.Max;
      case 2:
        return FanSpeed.Custom;
      default:
        throw "Invalid Fan State";
    }
  }
}
