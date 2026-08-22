import 'package:flutter/material.dart';

class ListWidget<T> extends StatelessWidget {
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
  //show only fist few row
  final int? maxItems;

  const ListWidget({
    required this.items,
    required this.column,
    required this.rowBuilder,
    this.columnFlex,
    this.onTap,
    this.maxItems,
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

    return Column(
      children: [
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
                  padding: const EdgeInsets.symmetric(
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
    );
  }
}
