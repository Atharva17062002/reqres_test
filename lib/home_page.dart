import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'user_data.dart';

import 'service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  ApiService apiService = ApiService();
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      final data = await apiService.getUsers();
      List<User> userList = [];
      for (var user in data) {
        userList.add(User.fromJson(user));
      }
      setState(() {
        users = userList;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createUser() async {
    try {
      final response = await apiService.createUser(
          nameController.text, emailController.text);
      final data = response;
      print('New user created: $data');
    } catch (error) {
      print('Error creating user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zigy Users App'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(users[index].avatar),
                          ),
                          title: Text(
                              '${users[index].firstName} ${users[index].lastName}'),
                          subtitle: Text(users[index].email),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: createUser,
                          child: Text('Create'),
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
