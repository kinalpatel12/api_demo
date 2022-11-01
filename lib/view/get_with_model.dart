import 'package:api_app/view/serch_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api_service/api_service.dart';
import '../model/product_model.dart';

class GetWithModel extends StatefulWidget {
  const GetWithModel({Key? key}) : super(key: key);

  @override
  State<GetWithModel> createState() => _GetWithModelState();
}

class _GetWithModelState extends State<GetWithModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchBar(ApiServices.productList));
            },
            icon: Icon(Icons.search_rounded))
      ]),
      body: FutureBuilder(
        future: ApiServices.getWithModel(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final products = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(products.image.toString()),
                  ),
                  title: Text(products.title.toString()),
                  subtitle: Text(products.rating!.count.toString()),
                );
              },
            );
          } else {
            return Center(
                child: CupertinoActivityIndicator(
              radius: 15,
            ));
          }
        },
      ),
    );
  }
}
