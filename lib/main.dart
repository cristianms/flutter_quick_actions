import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String shortcut = 'nenhuma_quick_action_selecionada';

  @override
  void initState() {
    super.initState();
    // Inicializa QuiActions
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
    });
    // Define atalhos
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Action one',
        icon: 'AppIcon', // Imagem disponível apenas para iOS
      ),
      const ShortcutItem(
        type: 'action_two',
        localizedTitle: 'Action two',
        icon: 'ic_launcher', // Imagem disponível apenas para Android
      ),
    ]).then((value) {
      // Aqui identificamos que se a aplicação foi iniciada por um atalho ou não
      setState(() {
        // Foi utilizado um atalho...
        if (shortcut != 'nenhuma_quick_action_selecionada') {
          if (shortcut == 'action_one') {
            print('Redirecionando para a página UM');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PageUm()));
          }
          if (shortcut == 'action_two') {
            print('Redirecionando para a página DOIS');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PageDois()));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Se você está nessa tela significa que não usou uma Quick Action...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class PageUm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UM')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Se você está nessa tela significa que usou a Quick Action UM...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class PageDois extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DOIS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Se você está nessa tela significa que usou a Quick Action DOIS...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
