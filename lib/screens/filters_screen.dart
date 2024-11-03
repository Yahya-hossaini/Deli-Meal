import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilter;

  const FiltersScreen({
    super.key,
    required this.currentFilter,
    required this.saveFilters,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  //initializing the filters that we set for keep the sate of the screen
  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten']!;
    _vegetarian = widget.currentFilter['vegetarian']!;
    _vegan = widget.currentFilter['vegan']!;
    _lactoseFree = widget.currentFilter['lactose']!;
    super.initState();
  }

  //A builder methode for creating filtering tiles
  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool value) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).primaryColor,
      thumbColor: MaterialStateProperty.all(Colors.black),
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save, color: Colors.white,),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meal',
                  _glutenFree,
                  (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                const Divider(),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                const Divider(),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                const Divider(),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
