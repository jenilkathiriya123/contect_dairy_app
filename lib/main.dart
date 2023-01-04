import 'package:flutter/material.dart';

import 'Global.dart';
import 'Pages/2.dart';
import 'Pages/3.dart';
import 'Pages/4.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail': (context) => const Detail(),
        'contact': (context) => const Contact(),
        'edit': (context) => const Edit(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: (Global.contactList.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      (Global.isDark)
                          ? "assets/image/2.PNG"
                          : "assets/image/1.PNG",
                      scale: (Global.isDark) ? 0.8 : 0.6),
                  Text(
                    "You have no contact yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: (Global.isDark) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: Global.contactList.length,
              itemBuilder: (context, i) => Card(
                elevation: 3,
                shadowColor: (Global.isDark) ? Colors.white : Colors.black,
                child: ListTile(
                  tileColor: Global.isDark ? Colors.black : Colors.white,
                  leading: (Global.contactList[i]['file'] == null)
                      ? GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(context, 'contact',
                                arguments: i);
                            setState(() {});
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              "assets/images/person.png",
                            ),
                            backgroundColor: Colors.grey,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(context, 'contact',
                                arguments: i);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                (Global.contactList[i]['file'] != null)
                                    ? FileImage(Global.contactList[i]['file'])
                                    : null,
                          ),
                        ),
                  title: Text(
                    "${Global.contactList[i]['first']}${(Global.contactList[i]['last'] == null) ? "" : " ${Global.contactList[i]['last']}"}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Global.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    "${Global.contactList[i]['contact']}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Global.isDark ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          Global.call(
                              contact: Global.contactList[i]['contact']);
                        });
                      },
                      child: const Icon(Icons.phone,
                          color: Colors.green, size: 40)),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, 'detail');
            Global.firstController.clear();
            Global.lastController.clear();
            Global.contactController.clear();
            Global.emailController.clear();
            Global.lastName = null;
            Global.firstName = null;
            Global.contact = null;
            Global.email = null;
          });
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: (Global.isDark) ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
