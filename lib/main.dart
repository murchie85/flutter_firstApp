import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
MAIN runs MYAPP
MYAPP has a MYAppState() context
MYAppState ONLY HAS ONE VAR current

GIVE ME OPTIONS
----------------
CMD + SHIFT + Space inside parenthesis for options

EXTRACT TO WIDGET
-----------------
COMMAND SHIFT .

WRAP IN WIDGET
-----------

THIS WILL LET YOU STYLE STUFF

*/
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void nextGen() {
    current = WordPair.random();
    notifyListeners();
  }

  // -----EMPTY LIST OF WORDPARS
  var favourites = <WordPair>[];

  
  void toggleFavourite(){
    if(favourites.contains(current)){
      favourites.remove(current);
    }
    else{
      favourites.add(current);
    }
    notifyListeners();
    
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentPair = appState.current;
    
    // ICON TYPE
    IconData icon;

    if (appState.favourites.contains(currentPair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(currentPair: currentPair),
            // ---adds a transparent box
            SizedBox(height: 10),
            Row(
              //------dont take up all the horizontal space
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavourite();
                  },
                  icon: Icon(icon),
                  label: Text('like'),
                ),
                SizedBox(height: 10,),


                ElevatedButton(
                  
                  onPressed: () {
                    appState.nextGen();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.currentPair,
  });

  final WordPair currentPair;

  @override
  Widget build(BuildContext context) {
    // ----GET ME THE CURRENT THEME
    final theme = Theme.of(context);

    // -----STYLE FOR TEXT displayMedium is(display typeface
    // Calling copyWith() on displayMedium returns a copy of the 
    // text style with the changes you define. In this case, 
    //you're only changing the text's color.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary

    );
    
    // ----CARD IS AN ACTUAL EXT WIDGET
    return Card(
      // -----
      color: theme.colorScheme.primary,
      // ---- shadow
      elevation: 30,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          currentPair.asLowerCase, 
          style:style,
          semanticsLabel: "${currentPair.first} ${currentPair.second}",
          ),
      ),
    );
  }
}
