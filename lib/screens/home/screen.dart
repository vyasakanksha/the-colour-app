import 'package:flutter/material.dart';

// Consts
import 'package:my_app/consts/colours.dart' as Colours;
import 'package:my_app/consts/strings.dart' as Strings;

// Widgets
import 'package:my_app/screens/home/widgets/colour.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pickAColour),
      ),
      body: buildBody(),
    );
  }

  Center buildBody() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ColourWidget(
              colour: Colours.black,
            ),
          ),
          Expanded(
            child: ColourWidget(
              colour: Colours.green,
            ),
          ),
          Expanded(
            child: ColourWidget(
              colour: Colours.red,
            ),
          ),
        ],
      ),
    );
  }
}
