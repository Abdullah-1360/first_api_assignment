import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/persondetails.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<PersonDetails>? personList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<PersonDetails>? data = await fetchData();
    setState(() {
      isLoading = false;
      personList = data ?? []; // Ensure it's non-null by default
    });
  }

  Future<List<PersonDetails>?> fetchData() async {
    try {
      final url = Uri.parse('http://192.168.100.188:3000/users');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => PersonDetails.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: personList?.length ?? 0, // Ensure no null errors
        itemBuilder: (context, index) {
          final person = personList?[index]; // Null-aware check
          if (person == null) {
            return Container(); // Handle case where person is null
          }
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(person.firstName[0]),
              ),
              title: Text('${person.firstName} ${person.lastName}'),
              subtitle: Text(person.email),
              trailing: Text(person.gender),
            ),
          );
        },
      ),
    );
  }
}
