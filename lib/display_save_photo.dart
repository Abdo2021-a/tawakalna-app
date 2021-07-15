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

//  dx = Provider.of<GetSveImage>(context, listen: false).dx;

class _DisplaySavePhotoState extends State<DisplaySavePhoto> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Provider.of<GetSveImage>(context, listen: false).dx;

    // Provider.of<GetSveImage>(context, listen: false).dy;
    // Provider.of<GetSveImage>(context, listen: false).dy_text;
    // Provider.of<GetSveImage>(context, listen: false).dx_text;
    print(Provider.of<GetSveImage>(context, listen: false).dx);

    print(Provider.of<GetSveImage>(context, listen: false).dy);
    print(Provider.of<GetSveImage>(context, listen: false).dx_text);

    print(
        " this is dx_text in savephoto        ${Provider.of<GetSveImage>(context, listen: false).dy_text}");
  }

  Offset positionIcon = Offset(200, 400);
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
                  left: Offset(
                          Provider.of<GetSveImage>(context, listen: false)
                              .dx_text,
                          Provider.of<GetSveImage>(context, listen: false)
                              .dy_text)
                      .dx,
                  top: Offset(
                          Provider.of<GetSveImage>(context, listen: false)
                              .dx_text,
                          Provider.of<GetSveImage>(context, listen: false)
                              .dy_text)
                      .dy,
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
                            Provider.of<GetSveImage>(
                              context,
                            ).datedayes,
                            style: TextStyle(
                              fontSize: 20,
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
            left: Offset(Provider.of<GetSveImage>(context, listen: false).dx,
                    Provider.of<GetSveImage>(context, listen: false).dy)
                .dx,
            top: Offset(Provider.of<GetSveImage>(context, listen: false).dx,
                    Provider.of<GetSveImage>(context, listen: false).dy)
                .dy,
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
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    ////////////////////////////////////////////////////////

                    setState(() {
                      Provider.of<GetSveImage>(context, listen: false)
                          .datetime = dateTime();
                      Provider.of<GetSveImage>(context, listen: false)
                          .datedayes = dateDays();
                      // Provider.of<GetSveImage>(context, listen: false)
                      //     .saveDateTime();
                      // Provider.of<GetSveImage>(context, listen: false)
                      //     .saveDatedayes();
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
                          // Provider.of<GetSveImage>(context, listen: false)
                          //     .saveDateTime();
                          // Provider.of<GetSveImage>(context, listen: false)
                          //     .saveDatedayes();
                        });
                      })),
            ),
          )
        ],
      ),
    );
  }
}
