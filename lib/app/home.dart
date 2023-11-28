import 'package:appnote/app/notes/edit.dart';
import 'package:appnote/components/cardnote.dart';
import 'package:appnote/components/crud.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:appnote/model/notemodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPre.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                sharedPre.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "error") {
                      return const Center(
                        child: Text(
                          "You do not Have Notes",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            onDelte: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Attention"),
                                      content: const Text("vous etes Sur ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "cancel",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              var response = await postRequest(
                                                  linkDelteNotes, {
                                                "id": snapshot.data['data'][i]
                                                        ['id_notes']
                                                    .toString(), 
                                                "imagename":
                                                    snapshot.data['data'][i]
                                                        ['notes_image']
                                              });
                                              if (response['status'] ==
                                                  'success') {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "home");
                                              }
                                            },
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ))
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNotes(
                                  notes: snapshot.data['data'][i],
                                ),
                              ));
                            },
                            // title: "${snapshot.data['data'][i]['notes_title']}",
                            // content:
                            //     "${snapshot.data['data'][i]['notes_content']}",
                            notemodel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("loading ... "),
                    );
                  }
                  return const Center(
                    child: Text("loading ... "),
                  );
                })
          ],
        ),
      ),
    );
  }
}
