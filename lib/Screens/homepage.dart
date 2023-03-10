import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? currentUser = FirebaseAuth.instance.currentUser;
  late StreamSubscription listener;
  TextEditingController searchTextEditingController =
      TextEditingController(text: "");
  FocusNode searchTextFieldFocusNode = FocusNode();
  static const List<String> sampleImages = [
    "assets/images/places/hanuman_temple.jpg",
    "assets/images/places/madkai_bridge.jpg",
    "assets/images/places/mahalaxmi_temple.jpg",
    "assets/images/places/mangeshi_temple.jpg",
    "assets/images/places/sangam_bakery.jpg",
    "assets/images/places/shantadurga_temple.jpg",
    "assets/images/places/st_roque_chapel.jpg",
    "assets/images/places/st_ana_bakery.jpg",
    "assets/images/places/temp2_min.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/home_page_background.png',
                    scale: 0.9,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 15,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()),
                                );
                              },
                              child: (currentUser?.photoURL) != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        (currentUser?.photoURL) ?? "",
                                        scale: 2.5,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Icon(
                                      Icons.account_circle,
                                      color: Colors.black,
                                      size: 42,
                                    ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Ponda",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/images/location_icon.png",
                                  scale: 0.8,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: TextFormField(
                            focusNode: searchTextFieldFocusNode,
                            controller: searchTextEditingController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                              filled: true,
                              contentPadding: EdgeInsets.all(0),
                              hintText: "Search",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 125,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sampleImages.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Image.asset(
                                      sampleImages[index],
                                      width: 125,
                                      height: 125,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "RECOMMENDATIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/filter_icon.png",
                        scale: 0.8,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Filter",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: sampleImages.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 50.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(125),
                    child: Image.asset(
                      sampleImages[index],
                      width: 125,
                      height: 125,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
