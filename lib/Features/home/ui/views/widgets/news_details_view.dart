import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Core/helpers/spacing.dart';
import 'package:news_app_eyego/Features/home/data/models/artical_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({
    Key? key,
    required this.articleModel,
    required this.category,
  }) : super(key: key);

  final ArticleModel articleModel;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: articleModel.image ?? '',
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            verticalSpace(12),
            Text(
              articleModel.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(8),
            Text(
              articleModel.subTitle ?? 'No description',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
            verticalSpace(20),
            ElevatedButton(
              onPressed: () async {
                if (articleModel.url != null) {
                  final uri = Uri.parse(articleModel.url!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch URL')),
                    );
                  }
                }
              },
              child: const Text('Read More'),
            )
          ],
        ),
      ),
    );
  }
}
