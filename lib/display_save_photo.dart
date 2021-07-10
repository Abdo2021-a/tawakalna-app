import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myphoto/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'provider/save_get_image.dart';

class DisplaySavePhoto extends StatefulWidget {
  @override
  _DisplaySavePhotoState createState() => _DisplaySavePhotoState();
}

class _DisplaySavePhotoState extends State<DisplaySavePhoto> {
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

  whenIconDrag() {
    return Container(
      child: Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("ar_SA", null).then((_) => dateTime());
    initializeDateFormatting("ar_SA", null).then((_) => dateDays());
    return Scaffold(
      body: Stack(
        children: [
          Provider.of<GetSveImage>(context).imagepath == null
              ? Center(
                  child: Text("no image please try agian"),
                )
              : Image.file(
                  File(Provider.of<GetSveImage>(context).imagepath),
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
                          Provider.of<GetSveImage>(
                            context,
                          ).datetime,
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
                            Provider.of<GetSveImage>(
                              context,
                            ).datedayes,
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
                          //     Provider.of<GetSveImage>(
                          //       context,
                          //     ).datetime,
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
                          //     Provider.of<GetSveImage>(
                          //       context,
                          //     ).datedayes,
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
          Align(
            alignment: FractionalOffset(1, 0.1),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddPhoto();
                    //
                  }));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                )),
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
                    ////////////////////////////////////////////////////////

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
