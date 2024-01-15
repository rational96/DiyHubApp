import 'package:flutter/material.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({Key? key}) : super(key: key);
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _materialsControllers = [TextEditingController()];
  final List<TextEditingController> _stepsControllers = [TextEditingController()];

  void _saveProjectDetails() {
    // Implement your save logic here
    print('Save project details');
  }

  void _addNewMaterialField() {
    setState(() {
      _materialsControllers.add(TextEditingController());
    });
  }

  void _addNewStepField() {
    setState(() {
      _stepsControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIY HUB'), 
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Titles', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Project Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text('Materials', style: Theme.of(context).textTheme.titleLarge),
              for (var controller in _materialsControllers)
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter material',
                  ),
                ),
              TextButton(
                onPressed: _addNewMaterialField,
                child: const Text('Add Material'),
              ),
              const SizedBox(height: 16),
              Text('Steps', style: Theme.of(context).textTheme.titleLarge),
              for (var controller in _stepsControllers)
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter step',
                  ),
                ),
              TextButton(
                onPressed: _addNewStepField,
                child: const Text('Add Step'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveProjectDetails,
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}