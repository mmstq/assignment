import 'package:assignment/provider/homepage_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider(),
        builder: (BuildContext context, Widget? child) =>
            Consumer(builder: (BuildContext context, HomeProvider provider, Widget? child) {
              if(provider.articles.isNotEmpty){
                return ListView.builder(
                    itemCount: provider.articles.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                                imageUrl: provider.articles[index].urlToImage??'',
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error, size: 40,),
                                    const SizedBox(height: 8,),
                                    Text('No Image', style: Theme.of(context).textTheme.titleLarge,)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text(provider.articles[index].title??'No Title', style: Theme.of(context).textTheme.titleMedium,),
                          ],
                        ),

                      );
                });
              }else{
                return const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}
