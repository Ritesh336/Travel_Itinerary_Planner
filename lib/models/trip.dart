import 'dart:math';

class Trip {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Day> days;
  final List<TodoItem> todoList;
  final List<Expense> expenses;
  final int destinations;
  bool completed;

  Trip({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.todoList,
    required this.expenses,
    required this.destinations,
    this.completed = false,
  });

  // Calculate total expense
  double get totalExpense {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }


  factory Trip.create({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required int destinations,
  }) {
    final id = Random().nextInt(10000).toString();
    final dayCount = endDate.difference(startDate).inDays + 1;
   
    final days = List.generate(
      dayCount,
      (index) {
        final date = startDate.add(Duration(days: index));
        return Day.create(
          date: date,
          title: 'Day ${index + 1}',
        );
      },
    );
   
    return Trip(
      id: id,
      name: name,
      startDate: startDate,
      endDate: endDate,
      days: days,
      todoList: [],
      expenses: [],
      destinations: destinations,
      completed: false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'days': days.map((day) => day.toJson()).toList(),
      'todoList': todoList.map((item) => item.toJson()).toList(),
      'expenses': expenses.map((expense) => expense.toJson()).toList(),
      'destinations': destinations,
      'completed': completed, 
    };
  }


  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      days: (json['days'] as List).map((dayJson) => Day.fromJson(dayJson)).toList(),
      todoList: (json['todoList'] as List).map((todoJson) => TodoItem.fromJson(todoJson)).toList(),
      expenses: (json['expenses'] as List).map((expenseJson) => Expense.fromJson(expenseJson)).toList(),
      destinations: json['destinations'],
      completed: json['completed'] ?? false,
    );
  }
}


class Day {
  final String id;
  final DateTime date;
  final String title;
  final List<Activity> activities;

  Day({
    required this.id,
    required this.date,
    required this.title,
    required this.activities,
  });

  factory Day.create({
    required DateTime date,
    required String title,
  }) {
    return Day(
      id: Random().nextInt(10000).toString(),
      date: date,
      title: title,
      activities: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'activities': activities.map((activity) => activity.toJson()).toList(),
    };
  }

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      activities: (json['activities'] as List).map((activityJson) => Activity.fromJson(activityJson)).toList(),
    );
  }
}


class Activity {
  final String id;
  final String name;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final double cost;

  Activity({
    required this.id,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'startTime': {'hour': startTime.hour, 'minute': startTime.minute},
      'endTime': {'hour': endTime.hour, 'minute': endTime.minute},
      'location': location,
      'cost': cost,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      startTime: TimeOfDay(hour: json['startTime']['hour'], minute: json['startTime']['minute']),
      endTime: TimeOfDay(hour: json['endTime']['hour'], minute: json['endTime']['minute']),
      location: json['location'],
      cost: json['cost'],
    );
  }
}


class TimeOfDay {
  final int hour;
  final int minute;

  TimeOfDay({required this.hour, required this.minute});

  String format() {
    final period = hour >= 12 ? 'PM' : 'AM';
    final hourIn12 = hour % 12 == 0 ? 12 : hour % 12;
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourIn12:$minuteStr $period';
  }
}


class TodoItem {
  final String id;
  final String title;
  bool completed;

  TodoItem({
    required this.id,
    required this.title,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}
