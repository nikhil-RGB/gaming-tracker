// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:gaming_tracker/models/Preference.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';
import 'package:gap/gap.dart';

class PerformancePage extends StatefulWidget {
  PerformancePage(
      {super.key, required this.gameDataModel, required this.dateTime});
  GameDataModel gameDataModel;
  late PlayInformation playinfo;
  DateTime dateTime;
  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  final TextEditingController _hours = TextEditingController();
  late final TextEditingController _CPU;
  late final TextEditingController _GPU;
  // ignore: prefer_final_fields
  late List<bool> _selectedPerformance;

  late List<bool> _selectedFans;
  @override
  void initState() {
    Preference prefs = widget.gameDataModel.settings;
    _CPU = TextEditingController(text: prefs.CPU_FAN.toString());
    _GPU = TextEditingController(text: prefs.GPU_FAN.toString());
    _selectedPerformance = prefs.powerList();
    _selectedFans = prefs.fanList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(20),
              Text(
                widget.gameDataModel.game_name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              buildHoursField(),
              const Gap(6),
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_hours.text.isEmpty || double.parse(_hours.text) > 24) {
            Fluttertoast.showToast(
              msg: "Invalid number of hours entered!",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
            );
            return;
          }
          PlayInformation pl_info = PlayInformation(
              game: widget.gameDataModel,
              hours: double.parse(_hours.text),
              performance_mode: readPowerMode(),
              fan_speed: readFanMode(),
              CPU_FAN: int.parse(_CPU.text),
              GPU_FAN: int.parse(_GPU.text));
          DailyInfoList obj = DailyInfoList.fromDate(widget.dateTime);
          obj.addGamingSession(pl_info);
          obj.updateInfo();

          //Add code to show Flutter toast
          Fluttertoast.showToast(
              msg: "Session Saved!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 41, 40, 40),
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (Route<dynamic> route) => false);
        },
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            "Save",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //builds the hours field
  Widget buildHoursField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hours Played",
            style: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {});
            },
            inputFormatters: [
              DecimalEnforcer(),
            ],
            controller: _hours,
            maxLength: 40,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter hours played here(decimal)",
            ),
          ),
        ],
      ),
    );
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

  //Fan buttons
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

class DecimalEnforcer extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    // Allow only one period
    if ('.'.allMatches(newText).length <= 1 &&
        (!newText.contains(RegExp(r'[^0-9.]')))) {
      return newValue;
    }
    return oldValue;
  }
}
