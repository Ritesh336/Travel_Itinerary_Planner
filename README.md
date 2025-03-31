# Travel Itinerary Planner

## Project Overview

Travel Itinerary Planner is a mobile application designed to streamline the process of planning and managing trips. Built with Flutter, this app provides travelers with an intuitive interface to organize their journey details in one central location. The application features a clean, modern design with support for both light and dark themes to enhance user experience across different environments.

## Key Features

- **Trip Management**: Create, view, edit, and archive trips with comprehensive details including dates, destinations, and completion status
- **Day-by-Day Planning**: Organize activities for each day of your trip with time slots, locations, and cost tracking
- **To-Do Lists**: Create and manage pre-trip tasks with completion tracking to ensure nothing is forgotten
- **Expense Tracking**: Monitor trip expenses by category with automatic totals calculation
- **Timeline View**: Visualize your trip with an interactive day-by-day timeline
- **Theme Support**: Toggle between light (blue/white) and dark (orange/black) themes based on preference
- **Local Storage**: All data is securely stored on the device using SharedPreferences

## Technical Implementation

The application follows a structured architecture with clear separation of concerns:

- **Data Models**: Core classes (Trip, Day, Activity, TodoItem, Expense) with JSON serialization
- **State Management**: Provider pattern for managing application state and user preferences
- **UI Components**: Material Design widgets with custom theming and animations
- **Data Persistence**: Local storage implementation using SharedPreferences
- **Navigation**: Intuitive screen flow with consistent bottom navigation

## Project Structure

The codebase is organized into logical components:
- Models for data structure definition
- Screens for user interface implementation
- Theme components for styling management
- Provider classes for state management

  

## Future Enhancements

Planned features for future releases include:
- Cloud synchronization for backup and multi-device access
- Trip sharing capabilities
- Profile and account setup
- Integration with maps and transportation services
- AI implementation to provide estimated trip costs and recommend must-visit places
