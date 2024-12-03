import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'viewmodel/product_vm.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, vm, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: Container(decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.grey.shade800, width: 1.0)), height: 35, child: Padding(padding: const EdgeInsets.all(3), child: Text(vm.selectedProduct?.title ?? "Product Name", overflow: TextOverflow.ellipsis)))),
                    7.width,
                    Expanded(
                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Qty',
                            labelStyle: const TextStyle(fontSize: 14),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                          ),
                          onChanged: (value) {
                            vm.tempData = vm.tempData.copyWith(qty: value.toInt());
                          },
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          vm.tempData = vm.tempData.copyWith(title: vm.selectedProduct?.title);
                          if (vm.tempData.title?.isNotEmpty == true) {
                            vm.addProduct();
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                10.height,
                Expanded(
                  child: vm.productList.isEmpty
                      ? const Center(child: Text("No products available. Add new products!", style: TextStyle(fontSize: 14, color: Colors.grey)))
                      : ListView.builder(
                          itemCount: vm.productList.length,
                          itemBuilder: (context, index) {
                            final data = vm.productList[index];
                            return GestureDetector(
                              onTap: () {
                                vm.selectProduct(data);
                                vm.refresh();
                              },
                              child: Card(
                                elevation: 4,
                                color: Colors.teal.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data.title.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Cancel", style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
