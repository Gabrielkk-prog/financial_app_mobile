import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/services/secure_storage.dart';
import 'package:flutter/material.dart';


class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState () => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>{
   final _secureStorage = const SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                 //when we click on the button the signIn page is loading deleting the user cache on the process.
              Text("Nova Tela"),
              ElevatedButton(
              onPressed: () {
               _secureStorage.deleteOne(key: "CURRENT_USER").then(
              (_) => Navigator.popAndPushNamed(
              // ignore: use_build_context_synchronously
              context,
              NamedRoutes.initial
              ),
              );
              }, 
              child: Text("Logout"),),
            ],
          ),
        ),
    );
  }
}