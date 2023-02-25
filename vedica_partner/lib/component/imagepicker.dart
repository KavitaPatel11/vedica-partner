import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vedica_partner/app/modules/ekyc/controllers/ekyc_controller.dart';
import 'package:vedica_partner/utils/my_colors.dart';

class DefaultImagePicker extends StatefulWidget {
  String pickimage;
  DefaultImagePicker({super.key, required this.pickimage});

  @override
  State<DefaultImagePicker> createState() => _DefaultImagePickerState();
}

class _DefaultImagePickerState extends State<DefaultImagePicker> {
  final EkycController ekycController = Get.put(EkycController());
  XFile? imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: MyColor.accentWhite,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 200,
              width: double.infinity,
              alignment:
                  imageFile == null ? Alignment.center : Alignment.bottomRight,
              decoration: BoxDecoration(
                  color: MyColor.accentWhite.withOpacity(0.2),
                  image: imageFile != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(imageFile!.path)),
                        )
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://algorithmwatch.org/en/wp-content/uploads/2019/02/Hero-Comments-EU-HLEG-v1.jpg"))),
              child: IconButton(
                  onPressed: () {
                    openBottomSheet();
                  },
                  icon: Icon(
                    imageFile == null ? Icons.add_a_photo : Icons.edit,
                    color: imageFile == null
                        ? MyColor.accentWhite
                        : MyColor.primaryColor,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Pick Image From',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 10,
            color: MyColor.bgcolor.withOpacity(0.2),
          ),
          ListTile(
            onTap: () {
              _getImage(ImageSource.camera);
            },
            leading: Icon(Icons.camera),
            title: Text("Camera"),
          ),
          Divider(
            height: 10,
            color: MyColor.bgcolor.withOpacity(0.2),
          ),
          ListTile(
            onTap: () {
              _getImage(ImageSource.gallery);
            },
            leading: Icon(Icons.photo_album),
            title: Text("Gallery"),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  _getImage(ImageSource getsource) async {
    var pickedFile = await ImagePicker().pickImage(
      source: getsource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
        widget.pickimage == "1"
            ? ekycController.aadhar1 = File(imageFile!.path)
            : widget.pickimage == "2"
                ? ekycController.aadhar2 = File(imageFile!.path)
                : ekycController.panimage = File(imageFile!.path);
      });

      print("objec $imageFile");

      print("image1 ${ekycController.aadhar1}");
      print("image1 ${ekycController.aadhar2}");
      print("image3 ${ekycController.panimage}");
      ekycController.update();
      Get.back();
    }
  }
}
