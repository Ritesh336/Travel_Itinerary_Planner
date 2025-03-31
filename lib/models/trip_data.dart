import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'trip.dart';


class TripData extends ChangeNotifier {
  List<Trip> _trips = [];

  List<Trip> get trips => _trips;
 
  // Getter for active or upcoming trips
  List<Trip> get activeTrips => _trips.where((trip) => !trip.completed).toList();
 
  // Getter for completed trips
  List<Trip> get completedTrips => _trips.where((trip) => trip.completed).toList();

  Future<void> loadTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripsJson = prefs.getStringList('trips') ?? [];
   
    _trips = tripsJson.map((tripJson) => Trip.fromJson(json.decode(tripJson))).toList();
    notifyListeners();
  }

  Future<void> saveTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripsJson = _trips.map((trip) => json.encode(trip.toJson())).toList();
   
    await prefs.setStringList('trips', tripsJson);
  }

  void addTrip(Trip trip) {
    _trips.add(trip);
    saveTrips();
    notifyListeners();
  }

  void updateTrip(Trip trip) {
    final index = _trips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      _trips[index] = trip;
      saveTrips();
      notifyListeners();
    }
  }

  void deleteTrip(String id) {
    _trips.removeWhere((trip) => trip.id == id);
    saveTrips();
    notifyListeners();
  }


  Trip? getTripById(String id) {
    try {
      return _trips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      return null;
    }
  }
 
  // Method to toggle the completed status of a trip
  void toggleTripCompletion(String id) {
    final trip = getTripById(id);
    if (trip != null) {
      trip.completed = !trip.completed;
      saveTrips();
      notifyListeners();
    }
  }


  void addDayActivity(String tripId, String dayId, Activity activity) {
    final trip = getTripById(tripId);
    if (trip != null) {
      final day = trip.days.firstWhere((day) => day.id == dayId);
      day.activities.add(activity);
      saveTrips();
      notifyListeners();
    }
  }


  void toggleTodoItem(String tripId, String todoId) {
    final trip = getTripById(tripId);
    if (trip != null) {
      final todoItem = trip.todoList.firstWhere((item) => item.id == todoId);
      todoItem.completed = !todoItem.completed;
      saveTrips();
      notifyListeners();
    }
  }


  void addTodoItem(String tripId, TodoItem item) {
    final trip = getTripById(tripId);
    if (trip != null) {
      trip.todoList.add(item);
      saveTrips();
      notifyListeners();
    }
  }


  void addExpense(String tripId, Expense expense) {
    final trip = getTripById(tripId);
    if (trip != null) {
      trip.expenses.add(expense);
      saveTrips();
      notifyListeners();
    }
  }
}
