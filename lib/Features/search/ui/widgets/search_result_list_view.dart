import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Core/controllers/search_controller.dart';
import '../../../../Core/theming/styles.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticlesSearchController controller =
    Get.find<ArticlesSearchController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.articles.isEmpty) {
        return const Center(child: Text('No results found.'));
      }

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: controller.articles.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final article = controller.articles[index];

          return GestureDetector(
            onTap: () async {
              //  controller.fetchSearchArticles(query: article.title);
              try {
                await launch(
                  '${Uri.parse(article.url!)}',
                  forceSafariVC: true,
                );
              } on Exception catch (e) {
                GetSnackBar(
                  title: "Error",
                  message: "Unable to open the link ${e.toString()}",
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: SizedBox(
              height: 140,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(
                      article.image ?? '',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          article.title,
                          style: TextStyles.font13DarkBlueMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.subTitle?.isNotEmpty == true
                              ? article.subTitle!
                              : 'No description available',
                          style: TextStyles.font13DarkBlueMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}