import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:testproject/productadd.dart';
import 'package:testproject/viewmodel/product_vm.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, vm, child) {
      return Scaffold(
        appBar: AppBar(title: const Text("Product Screen"), backgroundColor: Colors.teal),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.grey, width: 2.0)),
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                vm.selectedProduct?.title ?? "Product Name",
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              )))),
                  8.width,
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.grey, width: 2.0)),
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              vm.selectedProduct != null ? vm.tempList.length.toString() : "Count",
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ))),
                  8.width,
                  ElevatedButton.icon(
                      onPressed: () {
                        vm.clearSelection();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddProduct();
                            });
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text(
                        "Add",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))
                ],
              ),
              16.height,
              const Divider(thickness: 1.5, color: Colors.teal),
              Expanded(
                child: vm.tempList.isEmpty
                    ? const Center(child: Text("No products available. Add new products!", style: TextStyle(fontSize: 14, color: Colors.grey)))
                    : ListView.builder(
                        itemCount: vm.tempList.length,
                        itemBuilder: (context, index) {
                          final data = vm.tempList[index];
                          return GestureDetector(
                            onTap: () {
                              vm.selectProduct(data);
                              vm.refresh();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.deepOrange, width: 1.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(data.title.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            vm.delete(data);
                                          },
                                          icon: const Icon(Icons.delete, color: Colors.red)),
                                      5.width,
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const AddProduct();
                                                });
                                          },
                                          icon: const Icon(Icons.add, color: Colors.blue))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
