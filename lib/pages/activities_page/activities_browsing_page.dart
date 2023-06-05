import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/widgets/activity_card.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ActivitiesBrowsingPage extends StatelessWidget {
  const ActivitiesBrowsingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Consumer<ActivitiesProvider>(
        builder: (context, activitiesProvider, child) {
          final activityiesData = activitiesProvider.activitiesData;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextBox("營隊活動"),
              const SizedBox(height: 60),
              LayoutBuilder(builder: (context, constraint) {
                const double cardWidth = 350;
                final colWidth = constraint.maxWidth;
                int cardCount;
                for (cardCount = 0;
                    colWidth >= cardWidth * (cardCount + 1) + 40 * cardCount;
                    cardCount++) {}
                return Wrap(
                  spacing: (colWidth - cardWidth * cardCount) / (cardCount - 1),
                  runSpacing: 60,
                  children: [
                    for (var activityData in activityiesData.values)
                      ActivityCard(
                        onTap: () => context.go(
                            "/${MyRouter.activities}/${activityData.id}/${MyRouter.intro}"),
                        title: activityData.title,
                        deadline: activityData.deadline,
                        calendar: activityData.calendar,
                        place: activityData.place,
                        audience: activityData.audience,
                        imageUrl: activityData.imageUrl,
                      )
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
