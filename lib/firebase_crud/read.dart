import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Read extends StatefulWidget {
  Read({Key? key}) : super(key: key);

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController address = TextEditingController();
  void updateUser(
      {String? id,
      String? name,
      String? email,
      String? phone,
      String? role,
      String? address}) async {
    Map<String, Object> userProfile = {};
    if (name == "") {
    } else {
      userProfile['name'] = name!;
    }
    if (email == "") {
    } else {
      userProfile['email'] = email!;
    }
    if (phone == "") {
    } else {
      userProfile['phone'] = phone!;
    }
    if (role == "") {
    } else {
      userProfile['role'] = role!;
    }
    if (address == "") {
    } else {
      userProfile['address'] = address!;
    }
    await firestore.collection("data").doc(id).update(userProfile);
  }

  void deleteUser(String id) async {
    await firestore.collection("data").doc(id).delete();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("data").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, i) {
                var result = snapshot.data!.docs[i];
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            // title: Text("What Do you Wanna Do?"),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                ElevatedButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ],
                            ));
                      },
                    );
                  },
                  child: Dismissible(
                    onDismissed: (_) {
                      deleteUser(result.id);
                    },
                    direction: DismissDirection.horizontal,
                    background: Icon(Icons.delete_forever_rounded),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content:
                                const Text("Are you sure you want to delete?"),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("DELETE")),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    key: UniqueKey(),
                    child: Card(
                        elevation: 4,
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Color.fromARGB(162, 251, 253, 255),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                                title: Column(
                                              children: [
                                                Text("Update Data"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: name,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "${result['name']}"),
                                                ),
                                                TextFormField(
                                                  controller: email,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "${result['email']}"),
                                                ),
                                                TextField(
                                                  controller: phone,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "${result['phone']}"),
                                                ),
                                                TextFormField(
                                                  controller: role,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "${result['role']}"),
                                                ),
                                                TextFormField(
                                                  controller: address,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "${result['address']}"),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        updateUser(
                                                            id: result.id,
                                                            name: name.text,
                                                            email: email.text,
                                                            phone: phone.text,
                                                            role: role.text,
                                                            address:
                                                                address.text);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                      },
                                                      child: Text("Update"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ));
                                          });
                                    },
                                    icon: Icon(Icons.edit_note)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ("Name: ${result['name']}"),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ("Email: ${result['email']}"),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ("Phone: ${result['phone']}"),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ("User Role: ${result['role']}"),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ("Address: ${result['address']}"),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
