import 'package:ecommerce_app/view/admin_panel/admin_product_adding_page.dart';
import 'package:ecommerce_app/view_model/data_from_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDisplayPage extends StatelessWidget {
  const AdminDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDataController = Provider.of<DataFromFirebase>(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxisScrolled) => [
          const SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Products'),
          )
        ],
        body: RefreshIndicator(
          onRefresh: () => firebaseDataController.callPrductDetails(),
          child: Consumer<DataFromFirebase>(
            builder: (context, value, child) {
              return value.productsData.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(value.productsData[index].brandName),
                          subtitle: Text(
                              'Stock : ${value.productsData[index].productStock}'),
                          leading: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    value.productsData[index].productImages[0],
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: value.productsData.length)
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminProductAddingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
