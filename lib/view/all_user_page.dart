import 'package:api_app/api_service/all_user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_service/delete_api_service.dart';
import '../model/all_user.dart';

class AllUserPage extends StatefulWidget {
  const AllUserPage({Key? key}) : super(key: key);

  @override
  _AllUserPageState createState() => _AllUserPageState();
}

class _AllUserPageState extends State<AllUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AllUserData.getAllUser(),
        builder: (BuildContext context, AsyncSnapshot<AllUserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.users!.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final allUser = snapshot.data!.users![index];
                return Dismissible(
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        DeleteService.deleteService(userName: allUser.username);
                      }
                    },
                    background: Container(
                        height: 50,
                        color: Colors.red,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            )
                          ],
                        )),
                    key: ValueKey(allUser.username),
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(allUser.avatar.toString()),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(allUser.username.toString()),
                      ]),
                    ));
              },
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            );
          }
        },
      ),
    );
  }
}
