import 'package:flutter/material.dart';
import 'mongoConnect.dart';

class DisplayProjectPage extends StatefulWidget {
  final String projectName;
  DisplayProjectPage({Key? key, required this.projectName}) : super(key: key);

  @override
  _DisplayProjectPageState createState() => _DisplayProjectPageState();
}

class _DisplayProjectPageState extends State<DisplayProjectPage> {
  late Map<String, dynamic>? projectData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProjectData();
  }

  void loadProjectData() async {
    projectData = await DatabaseManager().getProjectData(widget.projectName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIY HUB'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.projectName, 
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              '@${projectData?['username']??''}', 
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Materials',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        height: 150, 
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: projectData?['materials']?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0), 
                              child: Text(
                                projectData?['materials'][index] ?? '',
                                style: const TextStyle(fontSize: 20), 
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Steps',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        height: 350, 
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: projectData?['steps']?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                projectData?['steps'][index] ?? '',
                                style: const TextStyle(fontSize: 20), 
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

