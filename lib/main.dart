import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/homescreen.dart';

import 'viewmodel/product_vm.dart';

void main() {
   runApp( ChangeNotifierProvider(
      create: (context) => ProductViewModel(),
      child: const MaterialApp(
        home: MyApp(),
      ),
    ),);
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductScreen(),
    );
  }
}
