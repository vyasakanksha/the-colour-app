import 'package:flutter/material.dart';
import "package:p5/p5.dart";
import 'package:logger/logger.dart';
import 'package:my_app/services/database_service.dart';
import 'package:my_app/app/app.locator.dart';

class DemoSketch extends StatefulWidget {
  final String sketchTitle;
  final List<dynamic> data;
  const DemoSketch({Key? key, required this.sketchTitle, required this.data})
      : super(key: key);

  @override
  DemoSketchState createState() => DemoSketchState();
}

class DemoSketchState extends State<DemoSketch>
    with SingleTickerProviderStateMixin {
  final _logger = Logger();

  late _DemoSketch sketch;
  late PAnimator animator;

  @override
  void initState() {
    super.initState();
    sketch = _DemoSketch();
    _logger.d("data: $widget.data");

    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch.redraw();
      });
    });
    animator.run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sketchTitle.toString())),
      backgroundColor: const Color.fromARGB(255, 218, 16, 16),
      body: Center(
        child: PWidget(sketch),
      ),
    );
  }
}

class _DemoSketch extends PPainter {
  List<dynamic> data = [];

  Future getArtData() async {
    final _databaseService = locator<DatabaseService>();

    print("art data");
    data = await _databaseService.readData();
    print("DEBUG: $data");
    return data;
  }

  @override
  void preload() async {
    data = await getArtData();
  }

  @override
  void setup() async {
    size(300, 300);
    //data = await getArtData();
    //loadData(data);
  }

  @override
  void draw() {
    background(color(255, 255, 255));
  }

  void loadData(data) {
    print("DATA");
    // var result = Object.entries(data);
    print(data.length);

    for (var i = 0; i < data.length; i++) {
      var bubbleData = data[i];
      print("bubbleData $bubbleData");
      var id = bubbleData["id"];
      print("id $id");
      var chex1 = bubbleData["colours"];
      var chex = bubbleData["colours"][0]["colour"];
      print("chex $chex");
      print("chex1 $chex1");
      Color colour;
      var secs = 0;
      Duration tf;
      if (chex != '') {
        // console.log(colour);
        colour = Color(chex);
        secs = bubbleData["colours"][0]["timestamp"]["_seconds"];
        tf = Duration(seconds: secs);
        print("tf $tf");
        print(id + ":" + colour + ":" + tf);

        // bubbles.push(new Bubble(random(width), random(height),       random(10,50), id,colour));
      }
    }
  }
}
