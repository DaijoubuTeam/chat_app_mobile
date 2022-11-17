import 'dart:io';

import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomModalFile extends StatefulWidget {
  const BottomModalFile({super.key});

  @override
  State<BottomModalFile> createState() => _BottomModalFileState();
}

class _BottomModalFileState extends State<BottomModalFile> {
  List<Map<String, dynamic>> media = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  for (var item in media) {
                    final urlDownloadImage = await FireStoreUploadFileService
                        .firseStoreService
                        .uploadFile(item["file"] as XFile);
                    print(urlDownloadImage);
                  }
                },
                child: Text("Send"),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Cancel"),
            ],
          ),
          // area show image
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[350],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return attachmentWidget(media[index]);
              }),
              itemCount: media.length,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Wrap(
            children: [
              iconTextButton("Take a photo", Colors.blue, () async {
                final images = await ImagePicker().pickMultiImage();
                if (images != null) {
                  for (var image in images) {
                    print(image.path);
                    XFile file = XFile(image.path);
                    setState(() {
                      media.add({"type": "image", "file": file});
                    });
                  }
                }
              },
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  context),
              iconTextButton(
                  "Choose a photo",
                  Colors.green,
                  () {},
                  const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  context),
              iconTextButton(
                  "Take a file",
                  Colors.orange,
                  () {},
                  const Icon(
                    Icons.file_present_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  context),
            ],
          )
        ],
      ),
    );
  }
}

Widget iconTextButton(
    String name, Color color, Function handleTap, Icon icon, BuildContext ctx) {
  return GestureDetector(
    onTap: () {
      handleTap();
    },
    child: Container(
      width: MediaQuery.of(ctx).size.width * 0.3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: icon,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(name),
        ],
      ),
    ),
  );
}

Widget attachmentWidget(Map<String, dynamic> attachment) {
  return Container(
    width: 100,
    height: 100,
    color: Colors.white,
    margin: const EdgeInsets.only(right: 10),
    child: Image.file(
      File((attachment["file"] as XFile).path),
      fit: BoxFit.cover,
    ),
  );
}
