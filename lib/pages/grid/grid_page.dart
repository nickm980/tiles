import 'package:app2/models/coordinates.dart';
import 'package:app2/models/tile_metadata.dart';
import 'package:app2/pages/grid/credits_modal.dart';
import 'package:app2/pages/grid/grid_canvas.dart';
import 'package:app2/models/grid.dart';
import 'package:app2/pages/grid/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  Offset localPosition = const Offset(-1, -1);
  Color currentColor = Colors.red;
  Grid grid = Grid(colors: {"1,2": 2, "1,3": 2}, width: 100, height: 100);
  TileMetadata metadata = TileMetadata.none();
  Coordinates coords = Coordinates(x: 0, y: 0);

  _changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  _onCursorChange(Coordinates newCoords) {
    print(coords.x);
    print(coords.y);
    setState(() {
      coords = newCoords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tiles"),
          actions: [
            OutlinedButton.icon(
                style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                    side: MaterialStateProperty.all(BorderSide.none)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return CreditsModal();
                      });
                },
                icon: Icon(FontAwesomeIcons.coins),
                label: Text("36 Credits")),
                IconButton.filled(onPressed: (){}, icon: Icon(FontAwesomeIcons.ellipsisV))
          ],
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: GridCanvas(
                  grid: grid,
                  onCursorChange: _onCursorChange,
                  currentColor: currentColor,
                )),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    constraints: BoxConstraints(maxHeight: 400),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ColorPallette(
                            colors: Grid.availableColors,
                            currentColor: currentColor,
                            onColorChange: _changeColor,
                          ),
                          Text("Costs ${metadata.price} credits"),
                          Text("Last Owner: ${metadata.author}"),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  grid.setPixel(
                                      coords.x, coords.y, currentColor);
                                });
                              },
                              child: Text(
                                  "Place Pixel (${metadata.x}, ${metadata.y})"))
                        ]))),
          ],
        ));
  }
}
