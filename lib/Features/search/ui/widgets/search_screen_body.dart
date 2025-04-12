import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/controllers/search_controller.dart';
import 'package:news_app_eyego/Features/search/ui/widgets/search_result_list_view.dart';
import 'custom_search_text_field.dart';

class SearchScreenBody extends StatelessWidget {
  SearchScreenBody({super.key});

  final ArticlesSearchController controller =
  Get.put(ArticlesSearchController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          CustomSearchTextField(
            onChanged: (query) {
              controller.fetchSearchArticles(query: query);
            },
          ),
          const SizedBox(height: 20),
          const Text('Search Result', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              switch (controller.state.value) {
                case ArticlesSearchStates.loading:
                  return const Center(child: CircularProgressIndicator());
                case ArticlesSearchStates.success:
                  return const SearchResultListView();
                case ArticlesSearchStates.failure:
                  return Center(child: Text(controller.errorMessage.value));
                case ArticlesSearchStates.empty:
                  return const Center(child: Text('No results found'));
                default:
                  return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}