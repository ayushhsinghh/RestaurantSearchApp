import 'package:flutter/material.dart';

import '../main.dart';

class SearchFilter extends StatefulWidget {
  final locationsType = [
    'city',
    'subzone',
    'zone',
    'landmark',
    'metro',
    'group'
  ];
  final sort = ['cost', 'rating', 'real_distance'];
  final order = ['asc', 'desc'];
  final double count = 20;
  SearchFilter({Key key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<Category> _categories;
  SearchOptions _searchOptions;
  List<int> _selectedCategories = [];
  Future<List<Category>> getCategories() async {
    final response = await dio.get('categories');
    final data = response.data['categories'];
    return data
        .map<Category>((json) => Category(
              json['categories']['id'],
              json['categories']['name'],
            ))
        .toList();
  }

  @override
  void initState() {
    _searchOptions = SearchOptions(
      locationType: widget.locationsType.first,
      sort: widget.sort.last,
      order: widget.order.first,
      count: widget.count,
    );
    getCategories().then((categories) {
      setState(() {
        _categories = categories;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Filters"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _categories is List<Category>
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                          spacing: 10,
                          children: List<Widget>.generate(_categories.length,
                              (index) {
                            final category = _categories[index];
                            final isSelected =
                                _searchOptions.category.contains(category.id);
                            return FilterChip(
                              label: Text(category.name),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                fontWeight: FontWeight.bold,
                              ),
                              selected: isSelected,
                              selectedColor: Colors.redAccent,
                              checkmarkColor: Colors.white,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _searchOptions.category.add(category.id);
                                  } else {
                                    _searchOptions.category.remove(category.id);
                                  }
                                });
                              },
                            );
                          })),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Location Type",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _searchOptions.locationType,
                  items: widget.locationsType
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _searchOptions.locationType = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Sort By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  spacing: 10,
                  children: widget.sort.map<ChoiceChip>((sort) {
                    return ChoiceChip(
                      label: Text(sort),
                      selected: _searchOptions.sort == sort,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _searchOptions.sort = sort;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Order By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (int i = 0; i < widget.order.length; i++)
                RadioListTile(
                    title: Text(widget.order[i]),
                    activeColor: Colors.redAccent,
                    value: widget.order[i],
                    groupValue: _searchOptions.order,
                    onChanged: (selection) {
                      setState(() {
                        _searchOptions.order = selection;
                      });
                    }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Number Of Result",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Slider(
                  value: _searchOptions.count ?? 5,
                  min: 5,
                  max: widget.count,
                  label: _searchOptions.count?.toString(),
                  divisions: 3,
                  onChanged: (value) {
                    setState(() {
                      _searchOptions.count = value;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final int id;
  final String name;
  const Category(this.id, this.name);
}

class SearchOptions {
  String locationType;
  String order;
  String sort;
  double count;
  List<int> category = [];

  SearchOptions({this.locationType, this.order, this.sort, this.count});
}
