// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:swipe_me/commenwidget/appbarwidget.dart';
import 'package:swipe_me/dbhelper/db2.dart';
import 'package:swipe_me/model/cont2model.dart';

import '../commenwidget/elevatedbuttonwidget.dart';
import '../dbhelper/dp.dart';
import '../repository/reposirory2.dart';
import '../repository/repository.dart';
import '../model/cont1model.dart';

class SaveImage extends StatefulWidget {
  const SaveImage({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveImage> createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  late Dphelper1 dphelper;
  late Dphelper2 dphelper2;

  // ignore: prefer_typing_uninitialized_variables
  var selectindex;
  // ignore: prefer_typing_uninitialized_variables
  var selectindex2;
  String? bookmarkindex2;
  String? bookmarkindex;
  Repository repository = Repository();
  Repository2 repository2 = Repository2();
  @override
  void initState() {
    super.initState();
    dphelper = Dphelper1();
    dphelper2 = Dphelper2();
    repository = Repository();
    repository2 = Repository2();
  }

  delete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text("Are you sure to Delete"),
            actions: [
              MyElevatedButton(
                onpress: () {
                  setState(() {
                    selectindex = bookmarkindex.toString();
                    repository.delete(selectindex);
                    Navigator.pop(context);
                  });
                  const SnackBar(content: Text("deleted success"));
                },
                text: 'yes',
              ),
              MyElevatedButton(
                text: "No",
                onpress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  delete2(BuildContext context, String imageUrl) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text("Are you sure to Delete"),
            actions: [
              MyElevatedButton(
                onpress: () {
                  setState(() {
                    selectindex2 = bookmarkindex2.toString();
                    repository2.delete(imageUrl);
                    Navigator.pop(context);
                  });
                  const SnackBar(content: Text("deleted success"));
                },
                text: 'yes',
              ),
              MyElevatedButton(
                text: "No",
                onpress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  bool isfistcontainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Save"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: repository.getimage(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Cont1modl>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            bookmarkindex =
                                snapshot.data![index].selectIndex.toString();
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.asset(
                                      snapshot.data![index].imageUrl!,
                                      fit: BoxFit.cover,
                                    )),
                                onLongPress: () {
                                  delete(context);
                                },
                              ),
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
              FutureBuilder(
                  future: repository2.getimage2(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Cont2model>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            bookmarkindex2 =
                                snapshot.data![index].selectIndex2.toString();
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.asset(
                                      snapshot.data![index].imageUrl!,
                                      fit: BoxFit.cover,
                                    )),
                                onLongPress: () {
                                  delete2(
                                      context,
                                      snapshot.data![index].imageUrl
                                          .toString());
                                },
                              ),
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ));
  }
}
