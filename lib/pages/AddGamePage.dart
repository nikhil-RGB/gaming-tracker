import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddGamePage extends StatefulWidget {
  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
            Gap(30),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

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
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 57, 54, 54),
          border: Border.all(
            color: Colors.redAccent,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Padding(
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
                )
              ],
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
            backgroundColor: Colors.redAccent,
          ),
          onPressed: () {
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
          },
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

  //TO-DO:Implement data persistence via hive boxes
  void save() {}
}
