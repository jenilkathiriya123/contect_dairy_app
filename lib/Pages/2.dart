import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:contact_d/Global.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
    file = Global.file;
  }

  @override
  Widget build(BuildContext context) {
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
          "Add Contact",
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
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                  Map<String, dynamic> myMap = {
                    'first': Global.firstName,
                    'last': Global.lastName,
                    'contact': Global.contact,
                    'email': Global.email,
                    'file': file,
                  };
                  Global.contactList.addAll([myMap]);
                }
              });
            },
            child: Icon(
              Icons.done,
              size: 30,
              color: (Global.isDark) ? const Color(0xff666666) : Colors.black,
            ),
          ),
          const SizedBox(width: 12),
        ],
        elevation: 0,
        backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      ),
      backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      body: Center(
        child: Form(
          key: key,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: const Alignment(0, -0.3),
                  children: [
                    (file == null)
                        ? const CircleAvatar(
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
                                    Global.firstName = val;
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
                                onChanged: (val) {
                                  setState(() {
                                    Global.lastName = val;
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
                                    Global.contact = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter 10 digit contact number...";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
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
                            TextFormField(
                              controller: Global.emailController,
                              onSaved: (val) {
                                setState(() {
                                  Global.email = val;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              cursorColor:
                                  (Global.isDark) ? Colors.grey : Colors.black,
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
                                hintText: "jenilkathiriya2gmail.com",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: (Global.isDark)
                                      ? Colors.white70
                                      : Colors.grey.shade700,
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
