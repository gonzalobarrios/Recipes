# Recipes

# Overview
This Recipes App allows users to explore a variety of recipes from different cuisines. It provides functionality to fetch and display recipes, manage caching, and display images in an efficient manner. The app follows the MVVM architecture pattern and is built with SwiftUI.

# Features
1. Fetches recipes from a network service
2. Displays a list of recipes, including their name and cuisine
3. Caches images locally for faster loading
4. Supports handling of loading states and error messages
5. Allows cleaning of old cached images

#Technologies Used
1. Swift 5
2. SwiftUI
3. Swift Concurrency: Async/Await for asynchronous operations (Swift 5)
4. UIKit (for handling images and other UI components)
5. Custom Image Caching
   
#Supported Versions
iOS 16 and above

#Project Structure
1. Model: Contains the data structures (e.g., Recipe) and networking logic (e.g., RecipeService).
2. ViewModel: Implements the business logic for the Recipes view (e.g., RecipesViewModel).
3. View: The UI elements, built with SwiftUI (e.g., RecipeCardView).
4. Helpers: Contains helper classes such as the image caching related clases (ImageLoader, ImageCache, DiskCache).

#Setup Instructions
1. Clone Repository:
   git clone https://github.com/gonzalobarrios/recipes-app.git
2. Open in Xcode:
   open Recipes.xcodeproj
3. Build and run the app in the simulator or on a physical device.

#Testing
1. Unit tests are written for key components, including the RecipesViewModel.
2. UI tests are included for core views like the recipe list.

To run the tests, simply select the Test target in Xcode and run the tests.

