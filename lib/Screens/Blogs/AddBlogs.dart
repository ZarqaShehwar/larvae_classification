import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FireStore.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:image_picker/image_picker.dart';
import "package:larvae_classification/commonUtils/Snackbar.dart";
import "package:larvae_classification/Extensions/Extension.dart";

class AddBlogs extends StatefulWidget {
  const AddBlogs({super.key});

  @override
  State<AddBlogs> createState() => _BlogsState();
}

class _BlogsState extends State<AddBlogs> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirestoreMethods _firestore = FirestoreMethods();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  File? selectedImage;
  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  uploadBlogData() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (image != null) {
          setState(() {
            isLoading = true;
          });
          String res = await _firestore.uploadBlogs(
            _descriptionController.text.capitalize(),
            image!,
            _titleController.text.capitalize(),
          );
          if (res == "Success") {
            Navigator.pop(context);
          }
          setState(() {
            isLoading = false;
          });

          ShowSnackBar(res, context);
        } else {
          ShowSnackBar("Please Select Image", context);
        }
      } catch (e) {
        ShowSnackBar(e.toString(), context);
      }
    }
  }

  selectImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                final returnImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (returnImage != null) {
                  setState(() {
                    selectedImage = File(returnImage.path);
                    image = selectedImage!.readAsBytesSync();
                  });
                }
              },
            ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();

                  final returnImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (returnImage != null) {
                    setState(() {
                      selectedImage = File(returnImage.path);
                      image = selectedImage!.readAsBytesSync();
                    });
                  }
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 24,
                color: Colors.black,
              )),
          title: const Text(
            "Blogs",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                    key: _formKey,
                    child: SizedBox(
                        child: Column(children: [
                      image != null
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(image!),
                                      fit: BoxFit.fill),
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            )
                          : Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                  child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return const LinearGradient(
                                          colors: <Color>[
                                            Colors.black,
                                            Colors.red,
                                          ],
                                        ).createShader(bounds);
                                      },
                                      child: IconButton(
                                          onPressed: () => {
                                                selectImage(),
                                              },
                                          icon: const Icon(
                                            Icons.upload,
                                            size: 40,
                                          ))))),
                      const SizedBox(height: 40),
                      InputField(
                        controller: _titleController,
                        lbltxt: 'Title',
                        hnttxt: 'Enter Title ',
                        kybrdtype: TextInputType.text,
                        color: Colors.black,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Title';
                          }

                          return null; // Validation passed
                        },
                        isBlogsTextField: true,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: _descriptionController,
                        lbltxt: 'Description',
                        hnttxt: 'Enter Description ',
                        kybrdtype: TextInputType.multiline,
                        color: Colors.black,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description';
                          }

                          return null; // Validation passed
                        },
                        isBlogsTextField: true,
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () => {uploadBlogData()},
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ]),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black))
                              : const Center(
                                  child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                        ),
                      ),
                    ]))))));
  }
}
