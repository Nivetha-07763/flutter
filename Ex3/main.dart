import 'package:flutter/material.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const StudentListScreen(),
    );
  }
}

class Student {
  String id;
  String name;
  String dept;
  String year;
  Student({
    required this.id,
    required this.name,
    required this.dept,
    required this.year,
  });
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> students = [];
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final yearController = TextEditingController();
  void _addStudent() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: deptController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  students.add(
                    Student(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      dept: deptController.text,
                      year: yearController.text,
                    ),
                  );
                });
                nameController.clear();
                deptController.clear();
                yearController.clear();
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(String id) {
    setState(() {
      students.removeWhere((student) => student.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Student Records',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                'No students added.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, index) {
                final student = students[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text(
                        student.name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(student.name),
                    subtitle: Text('${student.dept} - Year: ${student.year}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteStudent(student.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _addStudent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
