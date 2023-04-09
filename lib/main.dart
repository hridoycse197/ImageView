import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gridview/controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final imageC = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: imageC.allImageDiv
            .map((element) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 400,
                    child: MasonryGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 4,
                      itemCount: element.length > 3 ? 4 : element.length,
                      itemBuilder: (context, index) {
                        final x = element[index];
                        return GestureDetector(
                          onTap: () {
                            imageC.selectedList.clear();
                            imageC.selectedList.addAll(element);
                            Get.to(() => ExpandedImage());
                          },
                          child: (element.length > 3 && index == 3)
                              ? Stack(
                                  children: [
                                    Image.network(x.url),
                                    Positioned(
                                      left: 85,
                                      bottom: 65,
                                      child: CircleAvatar(
                                        child: Text((element.length - 4).toString()),
                                      ),
                                    )
                                  ],
                                )
                              : Image.network(x.url),
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      )),
    );
  }
}

class ExpandedImage extends StatelessWidget {
  final imageC = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(
        () => ListView(
            children: imageC.selectedList
                .map(
                  (y) => SizedBox(
                    height: 400,
                    child: Image.network(y.url),
                  ),
                )
                .toList()),
      ),
    );
  }
}
