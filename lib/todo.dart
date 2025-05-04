import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<String> _tasks = [];
  final TextEditingController _taskcontroller = TextEditingController();
  final TextEditingController _searchcontroller = TextEditingController();
  String _searchquery = '';
  void _addtasks() {
    String text = _taskcontroller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(text);
        _taskcontroller.clear();
      });
    }
  }

  void _deletetasks(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> searchbartasks =
        _tasks
            .where(
              (search) =>
                  search.toLowerCase().contains(_searchquery.toLowerCase()),
            )
            .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Todo list'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
           Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchcontroller,
                    onChanged: (value) {
                      _searchquery = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search tasks',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                    ),
                  ),
                ),
                 Expanded(
            child:
                searchbartasks.isEmpty
                    ? Center(
                      child: Image.network(
                        'https://cdni.iconscout.com/illustration/premium/thumb/businessman-completed-tasks-illustration-download-in-svg-png-gif-file-formats--no-task-list-tasklist-complete-done-emaily-pack-communication-illustrations-4202464.png',
                      ),
                    )
                    : ListView.builder(
                      itemCount: searchbartasks.length,
                      itemBuilder: (context, index) {
                        final tasks = searchbartasks[index];
                        return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: ListTile(
                              title: Text(tasks),
                              trailing: IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    int realindex = _tasks.indexOf(tasks);
                                    _deletetasks(realindex);
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          );
                      },
                    ),
          ),
          SizedBox(height: 80,)
              ],
            ),
          
         
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _taskcontroller,
                      decoration: InputDecoration(
                        hintText: 'Write your tasks here ...',
                       // border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addtasks();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 10.0,
                    ),
                    child: Text(
                      'Add tasks',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
