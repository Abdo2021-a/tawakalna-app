import 'package:flutter/material.dart';
import 'package:myphoto/provider/save_get_image.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../display_save_photo.dart';
import '../main.dart';

// ignore: must_be_immutable
class DispkayPhoto extends StatefulWidget {
  @override
  _DispkayPhotoState createState() => _DispkayPhotoState();
}

class _DispkayPhotoState extends State<DispkayPhoto> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetSveImage>(context, listen: false).saveImage();
    Provider.of<GetSveImage>(context, listen: false).saveDateTime();
    Provider.of<GetSveImage>(context, listen: false).saveDatedayes();
  }

  Offset positionIcon = Offset(200, 700);
  Offset positiondata = Offset(100, 400);
  whenIconDrag() {
    return Container(
      child: Text(''),
    );
  }

  String testing;
  String imagepath;

  dateTime() {
    String datetime = DateFormat.jm('ar_SA').format(DateTime.now());
    print(datetime);
    return datetime;
  }

  dateDays() {
    String datedayes = DateFormat.MMMMEEEEd('ar_SA').format(DateTime.now());
    print(datedayes);
    return datedayes;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    initializeDateFormatting("ar_SA", null).then((_) => dateTime());
    initializeDateFormatting("ar_SA", null).then((_) => dateDays());
    print("the picture path is $imagepath");

    return Scaffold(
      body: Stack(
        children: [
          Provider.of<GetSveImage>(context).imagee == null
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "no image please try agian",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.teal,
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return AddPhoto();
                              //
                            }));
                          },
                          child: Text(
                            "add Picture",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Image.file(
                  Provider.of<GetSveImage>(context).imagee,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          Stack(
            children: [
              Positioned(
                  left: positiondata.dx,
                  top: positiondata.dy,
                  child: Draggable(
                    onDraggableCanceled: (velocity, offset) {
                      setState(() {
                        positiondata = offset;
                        print(' original dx_text   ${offset.dx}');
                        print(" priginal dy_text   ${offset.dy}");
                        Provider.of<GetSveImage>(context, listen: false)
                            .dx_text = offset.dx;
                        Provider.of<GetSveImage>(context, listen: false)
                            .dy_text = offset.dy;
                        print(
                            "this is a dx_text :  ${Provider.of<GetSveImage>(context, listen: false).dx_text}");
                        print(
                            "this is a dy_text :   ${Provider.of<GetSveImage>(context, listen: false).dy_text}");
                        Provider.of<GetSveImage>(context, listen: false)
                            .saveDxText();
                        Provider.of<GetSveImage>(context, listen: false)
                            .saveDyTrxt();
                      });
                    },
                    child: InkWell(
                      onTap: () {
                        Provider.of<GetSveImage>(context, listen: false)
                            .saveDxText();
                        Provider.of<GetSveImage>(context, listen: false)
                            .saveDyTrxt();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Provider.of<GetSveImage>(context, listen: false)
                                .dateTime(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(' ، ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          Text(
                              Provider.of<GetSveImage>(context, listen: false)
                                  .dateDays(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    feedback: Container(
                      //
                      child: Row(
                        children: [
                          Icon(
                            Icons.undo_rounded,
                            size: 30,
                            color: Colors.white10,
                          ),
                          Icon(
                            Icons.undo_rounded,
                            size: 30,
                            color: Colors.white10,
                          ),
                          Icon(
                            Icons.undo_rounded,
                            size: 30,
                            color: Colors.white10,
                          ),
                        ],
                      ),
                      //
                      //
                    ),
                    childWhenDragging: whenIconDrag(),
                  )),
            ],
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: positionIcon.dx,
            top: positionIcon.dy,
            // bottom: positionIcon.dx,
            child: Draggable(
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  positionIcon = offset;
                  print(' original dx   ${offset.dx}');
                  print(" priginal dy   ${offset.dy}");
                  Provider.of<GetSveImage>(context, listen: false).dx =
                      offset.dx;
                  Provider.of<GetSveImage>(context, listen: false).dy =
                      offset.dy;
                  Provider.of<GetSveImage>(context, listen: false).saveDx();
                  Provider.of<GetSveImage>(context, listen: false).saveDy();
                });
              },
              childWhenDragging: whenIconDrag(),
              data: Colors.black,
              child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  splashColor: Colors.white10,
                  elevation: 0,
                  child: Icon(
                    Icons.refresh_sharp,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<GetSveImage>(context, listen: false)
                          .datetime = dateTime();
                      Provider.of<GetSveImage>(context, listen: false)
                          .datedayes = dateDays();
                      Provider.of<GetSveImage>(context, listen: false)
                          .saveDateTime();
                      Provider.of<GetSveImage>(context, listen: false)
                          .saveDatedayes();
                      Provider.of<GetSveImage>(context, listen: false).saveDx();
                      Provider.of<GetSveImage>(context, listen: false).saveDy();
                    });
                  }),
              feedback: Container(
                  child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(
                        Icons.refresh_sharp,
                        size: 35,
                      ),
                      onPressed: () {
                        setState(() {
                          Provider.of<GetSveImage>(context, listen: false)
                              .datetime = dateTime();
                          Provider.of<GetSveImage>(context, listen: false)
                              .datedayes = dateDays();
                          Provider.of<GetSveImage>(context, listen: false)
                              .saveDateTime();
                          Provider.of<GetSveImage>(context, listen: false)
                              .saveDatedayes();
                          Provider.of<GetSveImage>(context, listen: false)
                              .saveDx();
                          Provider.of<GetSveImage>(context, listen: false)
                              .saveDy();
                        });
                      })),
            ),
          )
        ],
      ),
    );
  }
}
