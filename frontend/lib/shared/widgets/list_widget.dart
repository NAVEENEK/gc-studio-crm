import 'package:flutter/material.dart';

class ListWidget<T> extends StatelessWidget {
  final String title;
  //actual data
  final List<T> items;
  //column name
  final List<String> column;
  //flex value
  final List<int>? columnFlex;
  //convert one item into values for each column
  final List<String> Function(T item) rowBuilder;
  //called when a row is tapped
  final void Function(T item)? onTap;
  //view all button
  final VoidCallback? onViewAll;
  //show view all
  final bool showViewAll;
  //show only fist few row
  final int? maxItems;
  //card height
  final double height;

  const ListWidget({
    required this.title,
    required this.items,
    required this.column,
    required this.rowBuilder,
    this.columnFlex,
    this.onTap,
    this.onViewAll,
    this.showViewAll = false,
    this.maxItems,
    this.height = 280,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displayItems = maxItems == null
        ? items
        : items.take(maxItems!).toList();

    final flex = columnFlex ?? List.generate(column.length, (_) => 1);
    assert(
      flex.length == column.length,
      "columnFlex length must match columns length",
    );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (showViewAll)
                    TextButton(
                      onPressed: onViewAll,
                      child: const Text("View All"),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              //column header
              Row(
                children: List.generate(
                  column.length,
                  (index) => Expanded(
                    flex: flex[index],
                    child: Text(
                      column[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              //list rows
              Expanded(
                child: ListView.separated(
                  itemCount: displayItems.length,
                  separatorBuilder: (_, _) =>
                      Divider(color: Colors.grey.shade200, height: 1),
                  itemBuilder: (context, index) {
                    final item = displayItems[index];
                    final value = rowBuilder(item);

                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: onTap == null ? null : () => onTap!(item),
                      child: Padding(
                        padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        child: Row(
                          children: List.generate(
                            value.length,
                            (column) => Expanded(
                              flex: flex[column],
                              child: Text(
                                value[column],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
