import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To-Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ListPage(title: '✨My To-Do List 📝'),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
// Variables
  // Purpose: Freeze text field on submit button tap and store text
  String _newTask = '';
  // Purpose: store tasks
  final List<String> _tasks=[];
  // Purpose: constantly store current value of text field
  final TextEditingController _controller = TextEditingController();

// Funtions
  // For Add button: Add new task to tasks
  void _addNewTask() {
    setState(() {
      //Freeze input field value
      _newTask = _controller.text.trim();
      if (_newTask != ''){
        // If it is not empty, add new task to tasks
        _tasks.add(_newTask);
        // Empty new task and erase text field content
        _newTask='';
        _controller.clear(); 
      }
    });
  }
  // For tapping on List Tiles, delete tile + add to text field
  void _deleteTask(int index){
    setState(() {
      // Update Text Field
      _controller.text = _tasks[index];
      // Remove from tasks
      _tasks.remove(_tasks[index]);
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Build on context color
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding:  const EdgeInsets.all(32),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text('What are you getting to do today?'),
            
            TextField(
              // COnnect text field to controller so that
              // you can use its methods
              controller: _controller,
              textAlign: TextAlign.center,
            ),
                        
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _addNewTask,
              child: const Icon(Icons.add_circle),
            ),

            const SizedBox(height: 8),
            // Since you are in Column:
            // Add expanded to ListView to constrain it
            Expanded(
              child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    // Since you are in Row:
                    // Add Expanded to ListTile to contrain it
                    Expanded(
                      child:ListTile(
                        title: Text(_tasks[index]),
                        onTap: ()=> _deleteTask(index),
                        ),
                    ),
                    Icon(
                      Icons.cancel,
                      color:Theme.of(context).colorScheme.inversePrimary
                    )
                  ],
                );
                
              },
              separatorBuilder: (_, __) => const Divider(), 
              itemCount: _tasks.length),
              )
            
            ]
          ),
        )
      
    );
  }
}
