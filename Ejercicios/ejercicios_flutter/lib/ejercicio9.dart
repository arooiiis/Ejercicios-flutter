import 'package:flutter/material.dart';

void main() {
  runApp(const Botones());
}

class Botones extends StatelessWidget {
  const Botones({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Botones App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botones App'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Common buttons pressed');
                    },
                    child: const Text('Common Buttons'),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      print('FloatingActionButton pressed');
                    },
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Extended FloatingActionButton pressed');
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text('Extended FAB'),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print('IconButton pressed');
                    },
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                  ),
                  ToggleButtons(
                    isSelected: const [true, false, false],
                    onPressed: (index) {
                      print('SegmentedButton $index pressed');
                    },
                    children: const [
                      Icon(Icons.star),
                      Icon(Icons.camera),
                      Icon(Icons.send),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const VerticalButtonsColumn(), // Agregamos la columna de botones a la derecha
        ],
      ),
    );
  }
}

class VerticalButtonsColumn extends StatelessWidget {
  const VerticalButtonsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              print('Small FloatingActionButton pressed');
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              print('Regular FloatingActionButton pressed');
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.large(
            onPressed: () {
              print('Large FloatingActionButton pressed');
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: () {
              print('Extended FloatingActionButton pressed');
            },
            label: const Text('Add'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
