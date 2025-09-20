import 'package:flutter/material.dart';

List<Map<String, dynamic>> daftarMahasiswa = [
  {"nama": "John Doe", "nomor_hp": "+1 (123) 456-7890"},
  {"nama": "Jane Smith", "nomor_hp": "+1 (234) 567-8901"},
  {"nama": "Michael Johnson", "nomor_hp": "+1 (345) 678-9012"},
  {"nama": "Emily Davis", "nomor_hp": "+1 (456) 789-0123"},
  {"nama": "William Wilson", "nomor_hp": "+1 (567) 890-1234"},
  {"nama": "Olivia Martinez", "nomor_hp": "+1 (678) 901-2345"},
  {"nama": "James Lee", "nomor_hp": "+1 (789) 012-3456"},
  {"nama": "Sophia Turner", "nomor_hp": "+1 (890) 123-4567"},
  {"nama": "Daniel Hall", "nomor_hp": "+1 (901) 234-5678"},
  {"nama": "Ava Harris", "nomor_hp": "+1 (012) 345-6789"},
  {"nama": "Liam Brown", "nomor_hp": "+1 (123) 234-5678"},
  {"nama": "Emma White", "nomor_hp": "+1 (234) 345-6789"},
  {"nama": "Noah Garcia", "nomor_hp": "+1 (345) 456-7890"},
  {"nama": "Oliver Rodriguez", "nomor_hp": "+1 (456) 567-8901"},
  {"nama": "Isabella Lopez", "nomor_hp": "+1 (567) 678-9012"},
  {"nama": "Mia Perez", "nomor_hp": "+1 (678) 789-0123"},
  {"nama": "Sophia Turner", "nomor_hp": "+1 (789) 890-1234"},
  {"nama": "Alexander Hall", "nomor_hp": "+1 (890) 901-2345"},
  {"nama": "Charlotte Martinez", "nomor_hp": "+1 (901) 012-3456"},
  {"nama": "Liam Davis", "nomor_hp": "+1 (012) 123-4567"},
];

Future<List<Map<String, dynamic>>> getData() {
  return Future.delayed(Duration(seconds: 1), () {
    return daftarMahasiswa;
  });
}

class FutureScreen extends StatelessWidget {
  const FutureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future Screen')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final student = snapshot.data![index];
              return ListTile(
                leading: const CircleAvatar(),
                title: Text(student['nama']),
                subtitle: Text(student['nomor_hp']),
              );
            },
          );
        },
      ),
    );
  }
}