import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../app/ColorSets.dart';

// Routable components
import './RatePark.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Browse Parks';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _counter = 0;
  late String _parkSearchValue;
  final _parkSearchValueController = TextEditingController(text: '');
  final List<String> _mockListData = <String>['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'];
  final List<String> _mockListSubtitleData = <String>['one sub', 'two sub', 'three sub', 'four sub', 'five sub', 'six sub', 'seven sub', 'eight sub', 'nine sub', 'ten sub'];

  @override
  void dispose() {
    super.dispose();
    _parkSearchValueController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _parkSearchValue = _parkSearchValueController.text.isNotEmpty ? _parkSearchValueController.text : '';
    _parkSearchValueController.addListener(() {
      setState(() {
        print(_parkSearchValueController.text);
        _parkSearchValue = _parkSearchValueController.text;
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _updateParkSearchValue (String value) {
    setState(() {
      _parkSearchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search for nearby parks',
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              controller: _parkSearchValueController,
            ),

            Text(this._parkSearchValue),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsetsDirectional.only(top: 16, bottom: 16),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _mockListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: EdgeInsets.all(2),
                          child: ListTile(
                            title: Text(_mockListData[index]),
                            subtitle: Text(_mockListSubtitleData[index]),
                            trailing: TextButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Rate'),
                                  Icon(
                                    Icons.star_rounded,
                                    color: BrandColors.starFilled,
                                    semanticLabel: 'Rating Star Filled',
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RateParkPage()),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      // separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
