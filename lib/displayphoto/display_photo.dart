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
    // Provider.of<GetSveImage>(context, listen: false).loadimage();
    Provider.of<GetSveImage>(context, listen: false).saveDateTime();
    Provider.of<GetSveImage>(context, listen: false).saveDatedayes();
  }

  whenIconDrag() {
    return Container(
      child: Text(''),
    );
  }

  String testing;
  String imagepath;
  Offset positionIcon = Offset(200, 700);
  Offset positiondata = Offset(100, 400);
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

  // @override
  // void initState() {
  //   super.initState();

  //   getimage();

  //   print(widget.myimage.path);

  //   print(widget.myimage.path);
  // }

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
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Provider.of<GetSveImage>(context, listen: false)
                              .dateTime(),
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(' ، ',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                        Text(
                            Provider.of<GetSveImage>(context, listen: false)
                                .dateDays(),
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                      ],
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
                          // Text(
                          //     Provider.of<GetSveImage>(context, listen: false)
                          //         .dateTime(),
                          //     style: TextStyle(
                          //       fontSize: 3,
                          //       color: Colors.black54,
                          //     )),
                          // Text(' ، ',
                          //     style: TextStyle(
                          //       fontSize: 3,
                          //       color: Colors.black54,
                          //     )),
                          // Text(
                          //     Provider.of<GetSveImage>(context, listen: false)
                          //         .dateDays(),
                          //     style: TextStyle(
                          //       fontSize: 3,
                          //       color: Colors.black54,
                          //     )),
                        ],
                      ),
                      //
                      //
                    ),
                    childWhenDragging: whenIconDrag(),
                  )),
            ],
          ),
          // Align(
          //   alignment: FractionalOffset(0.0, 0.1),
          //   child: IconButton(
          //       onPressed: () async {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //           return MyHomePage();
          //         }));
          //       },
          //       icon: Icon(
          //         Icons.arrow_back,
          //         color: Colors.white,
          //         size: 30,
          //       )),
          // ),
          // Align(
          //   alignment: FractionalOffset(1, 0.1),
          //   child: IconButton(
          //       splashColor: Colors.white,
          //       // onPressed: () {
          //       //   Provider.of<GetSveImage>(context, listen: false).saveImage();
          //       //   // Provider.of<GetSveImage>(context, listen: false).loadimage();
          //       //   Provider.of<GetSveImage>(context, listen: false)
          //       //       .saveDateTime();
          //       //   Provider.of<GetSveImage>(context, listen: false)
          //       //       .saveDatedayes();
          //       // },
          //       icon: Icon(
          //         Icons.save,
          //         color: Colors.teal,
          //         size: 30,
          //       )),
          // ),
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
                    size: 45,
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
                    });
                  }),
              feedback: Container(
                  child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(
                        Icons.refresh_sharp,
                        size: 45,
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
                        });
                      })),
            ),
          )
        ],
      ),
    );
  }
}
