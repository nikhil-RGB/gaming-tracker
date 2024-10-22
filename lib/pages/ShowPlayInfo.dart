import 'package:flutter/material.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:gaming_tracker/pages/DailyGamesPage.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';
import 'package:gap/gap.dart';

class ShowPlayInfo extends StatelessWidget {
  const ShowPlayInfo(
      {super.key,
      required this.gameInformation,
      required this.index,
      required this.date});
  final PlayInformation gameInformation;
  final int index;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gameInformation.game.game_name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              //Delete logic here
              DailyInfoList obj = DailyInfoList.fromDate(date);
              obj.removeGamingSession(index);
              obj.updateInfo();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => DailyGamePage(
                            referenceDay: date,
                          )),
                  (Route<dynamic> route) =>
                      route is MaterialPageRoute &&
                      route.builder(context) is LandingPage);
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
            readOnly: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller:
                TextEditingController(text: gameInformation.hours.toString()),
            maxLength: 40,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  //Performance buttons
  Widget performanceButtons() {
    int index = 0;
    switch (gameInformation.performance_mode) {
      case PowerMode.Balanced:
        index = 0;
        break;
      case PowerMode.Performance:
        index = 1;
        break;
      case PowerMode.Turbo:
        index = 2;
        break;
      default:
        throw "Invalid Power state";
    }
    List<bool> _selectedPerformance = [false, false, false];
    _selectedPerformance[index] = true;
    return ToggleButtons(
        isSelected: _selectedPerformance,
        fillColor: const Color(0xFFFC5555),
        onPressed: (index) {},
        splashColor: Colors.transparent,
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

  //Performance buttons
  Widget fanButtons() {
    int index = 0;
    switch (gameInformation.fan_speed) {
      case FanSpeed.Auto:
        index = 0;
        break;
      case FanSpeed.Max:
        index = 1;
        break;
      case FanSpeed.Custom:
        index = 2;
        break;
      default:
        throw "Invalid Fan Mode";
    }
    List<bool> _selectedFans = [false, false, false];
    _selectedFans[index] = true;
    return ToggleButtons(
        isSelected: _selectedFans,
        fillColor: const Color(0xFFFC5555),
        onPressed: (index) {},
        splashColor: Colors.transparent,
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
              readOnly: true,
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
              controller: TextEditingController(
                  text: isCPU
                      ? gameInformation.CPU_FAN.toString()
                      : gameInformation.GPU_FAN.toString()),
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
