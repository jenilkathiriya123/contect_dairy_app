import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Global.dart';
import 'package:share_plus/share_plus.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

message({required String contact}) async {
  final Uri sms = Uri(scheme: 'sms', path: contact);
  await launchUrl(sms);
}

email({required String email}) async {
  Uri mail = Uri(
    path: email,
    scheme: 'mailto',
  );
  await launchUrl(mail);
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    dynamic i = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Contacts",
          style: TextStyle(
              fontSize: 23,
              color: (Global.isDark) ? Colors.white : Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                Global.isDark = !Global.isDark;
              });
            },
            child: Container(
              width: 32,
              decoration: BoxDecoration(
                color: (Global.isDark) ? Colors.white : Colors.black,
                border: Border.all(
                    color: (Global.isDark)
                        ? const Color(0xffc4c4c4)
                        : const Color(0xffc4c4c4),
                    width: 4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Icon(Icons.more_vert_sharp,
              color: (Global.isDark) ? Colors.white : Colors.black, size: 30),
          const SizedBox(width: 7),
        ],
        elevation: 0,
        backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      ),
      backgroundColor: (Global.isDark) ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(flex: 2),
                const SizedBox(width: 10),
                Align(
                  alignment: Alignment.center,
                  child: (Global.contactList[i]['file'] == null)
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              const AssetImage("assets/images/person.png"),
                          backgroundColor: Colors.grey.shade500,
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              (Global.contactList[i]['file'] != null)
                                  ? FileImage(Global.contactList[i]['file'])
                                  : null,
                        ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await Global.contactList.removeAt(i);
                    Navigator.of(context).pop();
                    // setState(() {});
                  },
                  child: Icon(Icons.delete,
                      size: 30,
                      color: (Global.isDark)
                          ? const Color(0xff868686)
                          : Colors.black),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, 'edit', arguments: i);
                    });
                  },
                  child: Icon(Icons.edit,
                      size: 30,
                      color: (Global.isDark)
                          ? const Color(0xff868686)
                          : Colors.black),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${Global.contactList[i]['first']}${(Global.contactList[i]['last'] == null) ? "" : " ${Global.contactList[i]['last']}"}",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: (Global.isDark)
                            ? const Color(0xff868686)
                            : Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SelectableText(
                  "${Global.contactList[i]['contact']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: (Global.isDark)
                        ? const Color(0xff868686)
                        : Colors.black,
                  ),
                  toolbarOptions:
                      const ToolbarOptions(copy: true, selectAll: true),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(thickness: 2, color: Color(0xff868686)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Global.call(
                                  contact: Global.contactList[i]['contact']);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xff09ae2e),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.phone,
                                color: (Global.isDark)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              message(
                                  contact: Global.contactList[i]['contact']);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xffe9ac13),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.message,
                                color: (Global.isDark)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              email(email: Global.contactList[i]['email']);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xff01c0da),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.mail,
                                size: 26,
                                color: (Global.isDark)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share("${Global.contactList[i]['contact']}");
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xffda8300),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.share_outlined,
                                color: (Global.isDark)
                                    ? Colors.white
                                    : Colors.black,
                                size: 28),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Color(0xff868686)),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
