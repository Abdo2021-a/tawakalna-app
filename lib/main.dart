import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myphoto/provider/save_get_image.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'display_save_photo.dart';
import 'displayphoto/display_photo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetSveImage()),
      ],
      child: Tawakkalna(),
    ),
  );

  //
}

class Tawakkalna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Dinnex",
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // if (Provider.of<GetSveImage>(context).imagepath == null) {
    //   return;
    // } else {

    // }

    delay();
    Provider.of<GetSveImage>(context, listen: false).loadimage();

    // delay();
    //
    // delay();

    Provider.of<GetSveImage>(context, listen: false).loadDateTime();

    Provider.of<GetSveImage>(context, listen: false).loadDateDayes();
  }

  delay() async {
    await new Future.delayed(new Duration(seconds: 3), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoadScreen();
        //
      }));

      // Provider.of<GetSveImage>(context, listen: false).imagepath == null
      //     ? Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) {
      //         return AddPhoto();
      //         //
      //       }))
      //     : Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) {
      //         return DisplaySavePhoto();
      //         //
      //       }));
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("abdodaaaaaaaaaaa  ${widget.pathpicture}");
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'images/twakalna.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File _myimage;

  final imagepicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "إضافة صورة",
          style: TextStyle(fontSize: 25, fontFamily: "Dinnex"),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Container(
            padding: EdgeInsets.only(bottom: 6, left: 5, right: 5),
            child: Text(
              'أضف صورة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () async {
            await Provider.of<GetSveImage>(context, listen: false)
                .chooseImage();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DispkayPhoto();
              //
            }));
          },
        ),
      ),
    );
  }
}

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await new Future.delayed(new Duration(seconds: 8), () async {
      Provider.of<GetSveImage>(context, listen: false).imagepath == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return AddPhoto();
              //
            }))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return DisplaySavePhoto();
              //
            }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (a) => a),
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    "images/waitpic.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Center(
                  child: SpinKitRing(
                    lineWidth: 10,
                    duration: Duration(seconds: 15),
                    color: Colors.teal.shade600,
                    size: 200.0,
                  ),
                ),
                Center(
                    child: Text(
                  snapshot.hasData ? "${snapshot.data}" : '',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                )),
              ],
            ),
          );
        });
  }
}
