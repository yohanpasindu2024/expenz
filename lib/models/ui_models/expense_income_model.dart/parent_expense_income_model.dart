class ParentExpenseIncomeModel {
  final String id;
  final PathMapParent imagePathMap;
  final PathMapParent colorPathMap;
  final BaseCategory category;
  final String description;
  final double amount;
  final DateTime date;
  final DateTime time;

  ParentExpenseIncomeModel({
    required this.id,
    required this.imagePathMap,
    required this.colorPathMap,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
  }) {
    assert(amount >= 0, "Amount must be non-negative");
    assert(description.isNotEmpty, "Description must not be empty");
  }
}

abstract class BaseCategory {
  String get name;
}

class PathMapParent<T extends BaseCategory, V> {
  final Map<T, V> map;

  PathMapParent(this.map, Set<T> expectedKeys) {
    assert(
      map.keys.toSet().containsAll(expectedKeys),
      "All ${T.toString()} values must have an associated map entry.",
    );
  }

  V? getValue(T key) => map[key];
}

extension PathMapValidator<T extends BaseCategory, V> on PathMapParent<T, V> {
  void validateKeys(Iterable<T> keys) {
    assert(map.keys.toSet().containsAll(keys),
        "Not all keys are present in the map.");
  }
}
