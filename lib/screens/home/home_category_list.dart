import 'package:flutter/material.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/screens/home/home_category_item.dart';
import 'package:shoplocalto/utils/utils.dart';

class HomeCategoryList extends StatelessWidget {
  final List<CategoryModel2> category;
  final Function(CategoryModel2) onPress;
  final VoidCallback onOpenList;

  HomeCategoryList({
    Key key,
    this.category,
    this.onPress,
    this.onOpenList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('explore_shops'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: onOpenList,
                        child: Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            Translate.of(context).translate('view_list'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 24),
                    child: Wrap(
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: category.map(
                        (item) {
                          return HomeCategoryItem(
                            item: item,
                            onPressed: onPress,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
