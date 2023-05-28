import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:swipe_me/commenwidget/appbarwidget.dart';
import 'package:swipe_me/content.dart';
import 'package:swipe_me/dbhelper/dp.dart';
import 'package:swipe_me/model/cont2model.dart';

import 'package:swipe_me/views/setting_view.dart';

import '../dbhelper/db2.dart';
import '../repository/reposirory2.dart';
import '../repository/repository.dart';
import '../model/cont1model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random random = Random();
  bool issave = false;

  final List container1 = [
    // Cont1modl(imageUrl: 'assets/images/1.jpg'),
    // Cont1modl(imageUrl: 'assets/images/2.jpg'),
    // Cont1modl(imageUrl: 'assets/images/3.jpg'),
    // Cont1modl(imageUrl: 'assets/images/4.jpg'),
    // Cont1modl(imageUrl: 'assets/images/5.jpg'),
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
  ];

  final List<String> container2 = [
    "assets/images/6.jpg",
    "assets/images/7.jpg",
    "assets/images/8.jpg",
    "assets/images/9.jpg",
    "assets/images/10.jpg",
    "assets/images/11.jpg"
  ];
  // String images = "";
  // String images1 = "";
  bool isloading = false;
  late Dphelper1 dphelper;
  late Dphelper2 dphelper2;
  late Repository2 repository2;

  late Repository repository;
  @override
  void initState() {
    super.initState();
    dphelper = Dphelper1();
    dphelper2 = Dphelper2();
    // dphelper.setdb().whenComplete(() async {});
    repository = Repository();
    repository2 = Repository2();
  }

  int counter = 0;
  int counter1 = 0;
  String selectedIndex = "";
  String selectedIndex2 = "";
  List check2 = [];
  List check = [];
  List<Map<String, Object?>> save2 = [];
  List<Map<String, Object?>> save = [];
  // List<Cont1modl> savelist = [];
  // List<Cont2model> savelist2 = [];
  final Random _random = Random();
  void saveimage2() async {
    return await repository2.insertsave(
        Cont2model(imageUrl: selectedIndex2, selectIndex: counter1));
  }

  void saveimages() async {
    return await repository
        .saveimage(Cont1modl(selectIndex: counter, imageUrl: selectedIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Siwpe Me", action: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
            icon: const Icon(Icons.settings))
      ]),
      body: SingleChildScrollView(
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                counter = _random.nextInt(container1.length);
                counter1 = _random.nextInt(container2.length);
              });
            },
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: container1.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            SizedBox(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  container1[counter],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              left: 1,
                              child: IconButton(
                                  onPressed: () async {
                                    check.clear();
                                    // ignore: prefer_typing_uninitialized_variables

                                    final db = await dphelper.setdb();
                                    save = await db.rawQuery(
                                        'SELECT selectIndex from book1');
                                    for (int i = 0; i <= save.length - 1; i++) {
                                      check.add(
                                          save[i]['selectIndex'].toString());
                                    }
                                    int saved = 0;
                                    if (check.contains(counter.toString())) {
                                      saved = 1;
                                    }
                                    if (saved == 1) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("already in bookmark")));
                                    } else {
                                      check.add(counter);
                                      check = check.toSet().toList();
                                      selectedIndex = container1[counter];
                                      saveimages();
                                      check.clear();

                                      //ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("added to save")));
                                    }
                                  },
                                  icon: const Icon(Icons.bookmark)),
                            )
                          ],
                        );
                      }),
                ),
                size,
                size,
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: container2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                container2[counter1],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                bottom: 1,
                                left: 1,
                                child: IconButton(
                                    onPressed: () async {
                                      check2.clear();
                                      // ignore: prefer_typing_uninitialized_variables

                                      final db = await dphelper2.setdb2();
                                      save2 = await db!.rawQuery(
                                          'SELECT selectIndex from book2');
                                      for (int i = 0;
                                          i <= save2.length - 1;
                                          i++) {
                                        check2.add(
                                            save2[i]['selectIndex'].toString());
                                      }
                                      int saved2 = 0;
                                      if (check2
                                          .contains(counter1.toString())) {
                                        saved2 = 1;
                                      }
                                      if (saved2 == 1) {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "already in bookmark")));
                                      } else {
                                        check2.add(counter);
                                        check2 = check2.toSet().toList();
                                        selectedIndex2 = container2[counter1];
                                        saveimage2();
                                        check2.clear();

                                        //ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("added to save")));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.bookmark,
                                      color: Colors.black,
                                    )))
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
