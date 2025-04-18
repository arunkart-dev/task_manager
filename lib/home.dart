import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _tasks = [];
  final TextEditingController _taskcontroller = TextEditingController();
  final TextEditingController _searchcontroller = TextEditingController();
  String _searchquery = '';

  void _addtask() {
    String text = _taskcontroller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(text);
        _taskcontroller.clear();
      });
    }
  }

  void _deletetask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredtasks =
        _tasks
            .where(
              (task) => task.toLowerCase().contains(_searchquery.toLowerCase()),
            )
            .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Task Manager'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: _searchcontroller,
                  onChanged: (value) {
                    setState(() {
                      _searchquery = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search tasks',
                    filled: true,
                    fillColor: Colors.white30,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child:
                    filteredtasks.isEmpty
                        ? const Center(child: Text('No Tasks found !'))
                        : ListView.builder(
                          itemCount: filteredtasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredtasks[index];
                            return Dismissible(
                              key: Key(task),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                setState(() {
                                  int realindex = _tasks.indexOf(task);
                                  _deletetask(realindex);
                                });
                              },
                              child: Card(
                                color: Colors.white,
                                shadowColor: Colors.grey,
                                elevation: 3.0,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: ListTile(
                                    title: Text(
                                      task,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
              SizedBox(height: 80),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _taskcontroller,
                      decoration: InputDecoration(
                        hintText: 'Add new Task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: _addtask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 40),
                      elevation: 10.0,
                      minimumSize: Size(60, 60),
                    ),
                    child: Text('+'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
