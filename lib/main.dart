import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/trip_data.dart';
import 'theme/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // Initialize the trip data provider
  final tripData = TripData();
  await tripData.loadTrips();
 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tripData),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const TravelItineraryPlanner(),
    ),
  );
}


class TravelItineraryPlanner extends StatelessWidget {
  const TravelItineraryPlanner({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Travel Itinerary Planner',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
