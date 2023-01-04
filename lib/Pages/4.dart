import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Global.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? file;
  ImagePicker image = ImagePicker();

  camera() async {
    final cam = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(cam!.path);
    });
  }

  gallery() async {
    final gal = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(gal!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic i = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: (Global.isDark) ? const Color(0xff666666) : Colors.black,
          ),
        ),
        title: Text(
          "Edit Contact",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: (Global.isDark) ? const Color(0xff666666) : Colors.black),
        ),
        actions: [
          const SizedBox(width: 7),
          GestureDetector(
            onTap: () {
              setState(() {
                if (file == null) {
                  file = Global.contactList[i]['file'];
                } else {
                  Global.contactList[i]['file'] = file;
                }
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
              });
            },
            child: Icon(Icons.done,
                size: 30,
                color:
                    (Global.isDark) ? const Color(0xff666666) : Colors.black),
          ),
          const SizedBox(width: 12),
        ],
        elevation: 0,
        backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      ),
      backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: const Alignment(0, -0.3),
                  children: [
                    (file == null)
                        ? (Global.contactList[i]['file'] != null)
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: (Global.contactList[i]
                                            ['file'] !=
                                        null)
                                    ? FileImage(Global.contactList[i]['file'])
                                    : null,
                                backgroundColor: Colors.grey,
                              )
                            : const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(
                                  "assets/images/person.png",
                                ),
                                backgroundColor: Colors.grey,
                              )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: (file != null)
                                ? FileImage(File(file!.path))
                                : null,
                            backgroundColor: Colors.grey,
                          ),
                    Positioned(
                      top: 125,
                      left: 100,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                    "Choose any source for pick image."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        camera();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text("Camera"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        gallery();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text("Gallery"),
                                  ),
                                ],
                              ),
                            );
                            Global.file = file;
                          });
                        },
                        child: Container(
                          height: 33,
                          width: 33,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First Name",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: (Global.isDark)
                                    ? const Color(0xff666666)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: Global.firstController,
                                onSaved: (val) {
                                  setState(() {
                                    Global.contactList[i]['first'] = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter first name";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: (Global.isDark)
                                    ? Colors.grey
                                    : Colors.black,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: (Global.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  fillColor: (Global.isDark)
                                      ? const Color(0xff666666)
                                      : Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusColor: Colors.black,
                                  border: const OutlineInputBorder(),
                                  hintText: "jenil",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: (Global.isDark)
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Name",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: (Global.isDark)
                                    ? const Color(0xff666666)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: Global.lastController,
                                onSaved: (val) {
                                  setState(() {
                                    Global.contactList[i]['last'] = val;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: (Global.isDark)
                                    ? Colors.grey
                                    : Colors.black,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: (Global.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  fillColor: (Global.isDark)
                                      ? const Color(0xff666666)
                                      : Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusColor: Colors.black,
                                  border: const OutlineInputBorder(),
                                  hintText: "kathiriya",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: (Global.isDark)
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: (Global.isDark)
                                    ? const Color(0xff666666)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: Global.contactController,
                                onSaved: (val) {
                                  setState(() {
                                    Global.contactList[i]['contact'] = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter 10 digit contact number...";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                cursorColor: (Global.isDark)
                                    ? Colors.grey
                                    : Colors.black,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: (Global.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                maxLength: 14,
                                decoration: InputDecoration(
                                  fillColor: (Global.isDark)
                                      ? const Color(0xff666666)
                                      : Colors.white,
                                  filled: true,
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusColor: Colors.black,
                                  border: const OutlineInputBorder(),
                                  hintText: "+91 9428001856",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: (Global.isDark)
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: (Global.isDark)
                                    ? const Color(0xff666666)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: TextFormField(
                                controller: Global.emailController,
                                onSaved: (val) {
                                  setState(() {
                                    Global.contactList[i]['email'] = val;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                cursorColor: (Global.isDark)
                                    ? Colors.grey
                                    : Colors.black,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: (Global.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  fillColor: (Global.isDark)
                                      ? const Color(0xff666666)
                                      : Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusColor: Colors.black,
                                  border: const OutlineInputBorder(),
                                  hintText: "mit2238@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: (Global.isDark)
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
