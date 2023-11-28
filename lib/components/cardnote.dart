import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/model/notemodel.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDelte;
  // final String title;
  // final String content;
  final NoteModel notemodel;

  const CardNotes(
      {super.key,
      required this.onTap,
      // required this.title,
      // required this.content,
      required this.notemodel,
      required this.onDelte});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoute/${notemodel.notesImage}",
                  height: 125,
                  width: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  // title: Text(title),
                  // subtitle: Text(content),
                  title: Text("${notemodel.notesTitle}"),
                  subtitle: Text("${notemodel.notesContent}"),
                  trailing: IconButton(
                      onPressed: onDelte,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
