import 'dart:io';

import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isloading = false;

  addNotes() async {
    if (myfile == null)
      return AwesomeDialog(
        context: context,
        title: "attention",
        body: Text("s'il vous plait ajouter une photo"),
      ).show();
    if (formstate.currentState!.validate()) {
      //validate of text field
      isloading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPre.getString("id"),
          },
          myfile!);
      isloading = false;
      setState(() {});
      if (response["status"] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Edit Notes"),
      ),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextFormSign(
                        hint: "title",
                        mycontroller: title,
                        valid: (val) {
                          return validInput(val!, 1, 300);
                        }),
                    CustomTextFormSign(
                        hint: "content",
                        mycontroller: content,
                        valid: (val) {
                          return validInput(val!, 5, 20000);
                        }),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (content) => SizedBox(
                                  height: 130,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Choose Image : ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            "use Gallery",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            "use The Camera",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      textColor: Colors.white,
                      color: myfile == null
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : Colors.green,
                      child: const Text("choose Image "),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      textColor: Colors.white,
                      color: Colors.green,
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
