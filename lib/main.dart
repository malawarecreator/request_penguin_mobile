import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<MainApp> createState() => _MainAppState();
}



class _MainAppState extends State<MainApp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _postdata_controller = TextEditingController();
  String restext = "";
  String _controller2_text = "";
  String _postdata_controller_text = "";
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, 
        child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.web)),
            Tab(icon: Icon(Icons.accessibility_sharp))
          ]),
          title: const Text("Request Penguin"),
        ),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Text("GET Requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 25,),
              TextField(decoration: InputDecoration(
                
                border: OutlineInputBorder(),
                hintText: "Enter the URL for the Request"
              ),
              controller: _controller,
              ),

              SizedBox(height: 30,),
              ElevatedButton(onPressed: () async {
                
                String text = _controller.text;
                if (text.isEmpty) {
                  setState(() {
                    restext = "Please Enter a URL!";
                  });
                  return;
                }

                var uri = Uri.parse(text);

                try {
                  final res = await http.read(uri);
                  setState(() {
                    restext = res;
                  });
                } catch (e) {
                  setState(() {
                    restext = "Failed to fetch data ${e}";
                  });
                }
                
              }, child: Text("Make Request")),
              SizedBox(height: 30),
              Text(restext, style: TextStyle(fontSize: 16, color: Colors.black), textAlign: TextAlign.center,)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
           
            children: [
              Text("POST Requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 25),
              TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter the endpoint for the Request"
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: _postdata_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "JSON for post",
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: () async {
                
                String url_text = _controller2.text;
                String json_text = _postdata_controller.text;
                if (url_text.isEmpty || json_text.isEmpty) {
                  setState(() {
                    _controller2_text = "Please Enter the endpoint URL!";

                  });
                }
                var uri = Uri.parse(url_text);
                try {
                  final res = await http.post(
                    uri, 
                    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
                    body: json_text,

                  );
                  setState(() {
                    _controller2_text = res.body;
                    
                  });
                } catch (e) {
                  setState(() {
                    _controller2_text = "Failed to fetch data $e";
                  });
                }

                
              }, child: Text("Make Request")),


            ],
          ),
        ]),
      )),
      

    );
  }
}
