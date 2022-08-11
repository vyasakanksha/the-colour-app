import 'package:flutter/material.dart';
import 'package:my_app/screens/home/widgets/sketches/demo.dart';
import 'package:get/get.dart';
import 'package:my_app/services/database_service.dart';
import 'package:my_app/app/app.locator.dart';

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);
  final _databaseService = locator<DatabaseService>();
  static List<dynamic> data = [];

  List<String> folderName = [
    'Artist: Srinivas Mangipudi',
    'Artist: Jesal Mehta',
    'Artist: Michal Dziedziniewicz',
    'Artist: Akanksha Vyas'
  ];

  List<String> coverImageLinks = [
    "assets/images/srini.png",
    "assets/images/jes.png",
    "assets/images/michal.png",
    "assets/images/ak.png"
  ];

  List<Widget> routePaths = [
    DemoSketch(
      sketchTitle: "Demo",
      data: data,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  Center buildBody() {
    return Center(child: FutureBuilder<dynamic>(builder: (context, snapshot) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(50),
          child: Column(
            children: [
              Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  for (var i = 0; i < folderName.length; i++)
                    Column(
                      children: [
                        Material(
                          child: InkWell(
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    coverImageLinks[i],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () => Get.to(
                              routePaths[i],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          folderName[i],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
