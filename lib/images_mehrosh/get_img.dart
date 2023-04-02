import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:week2/images_mehrosh/share_save.dart';

class GetImages extends StatefulWidget {
  const GetImages({super.key});

  @override
  State<GetImages> createState() => _GetImagesState();
}

class _GetImagesState extends State<GetImages> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Images From Firestore")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("imgUrl").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              //   return ListView.builder(
              //   itemCount: snapshot.data!.docs.length,
              //   itemBuilder: (c, i) {
              //     return Image.network(snapshot.data!.docs[i].get("imgurl"));
              //   },
              // );
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (_) {

                        FirebaseFirestore.instance.collection("imgUrl").doc(snapshot.data!.docs[index].id).delete();
                        FirebaseStorage.instance
                            .refFromURL(snapshot.data!.docs[index].get('imgurl'))
                            .delete()
                            .then((value) {
                          print("Deleted");
                        }).catchError((e) {
                          print(e);
                          
                        });
                      },
                      direction: DismissDirection.vertical,
                      background: Icon(Icons.delete_forever_rounded),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you want to delete the image permenantly?"),
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
                      child: InkWell(
                         onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ShareSaveImg(
                          image: snapshot.data!.docs[index].get("imgurl"),
                        );
                      }));
                    },
                        child: Image.network(
                          snapshot.data!.docs[index].get("imgurl"),
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
