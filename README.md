# Recipes

### Summary:
This Recipes App allows users to explore a variety of recipes from different cuisines. It provides functionality to fetch and display recipes, manage caching, and display images in an efficient manner. The app follows the MVVM architecture pattern and is built with SwiftUI.
<img src="https://github.com/user-attachments/assets/37cbd318-9d9a-4aea-a841-2fca32fa744a" width="300" />
<img src="https://github.com/user-attachments/assets/44aaeb9f-5928-49ef-b655-08baaacc7293" width="300" />

### Focus Areas:
I prioritized the following areas in this project:
1. Fetching and Displaying Recipes: I focused on ensuring that recipes were correctly fetched from the network service and displayed efficiently with SwiftUI.
2. Image Caching: Implementing a custom image caching mechanism was important to improve performance and avoid repeatedly downloading images.
3. Error Handling: Ensuring that any network errors were properly handled and displayed was critical for a smooth user experience.

I chose to focus on these areas to ensure that the app performs well, especially in terms of network requests and UI responsiveness.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Approximately 8-11 hours were spent on this project:
1. 2 hours on setting up the project structure and building the Recipe model and service.
2. 2 hours on implementing the RecipesViewModel, handling asynchronous operations, and ensuring the UI updates correctly.
3. 2-3 hours on building the SwiftUI views and handling image loading/caching.
4. 2 hours writing tests for the ViewModel and UI.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
1. Image Caching Strategy: I implemented both in-memory caching (using ImageCache) and disk caching (using DiskCache). In-memory caching provides faster image retrieval, reducing loading times for images that are already fetched, while disk caching ensures that images persist across app sessions. The trade-off is that, while the in-memory cache can improve performance, it can also consume more memory, especially if there are a large number of images. Balancing between the two caching strategies allows the app to optimize both speed and memory usage, though for a very large number of images, the in-memory cache could still cause performance issues.

2. Network Error Handling: I opted to display generic error messages in the event of network failures, such as "An unknown error occurred," instead of distinguishing between all specific HTTP error codes. This decision was made to simplify error handling and reduce complexity in the codebase. While specific error messages could enhance the user experience by providing more context, it would require additional logic to handle various types of errors.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of this project is the error handling and feedback mechanism. While basic error messages are displayed, there is room for improvement in providing more specific feedback to users. For example, handling different error scenarios (network issues vs server issues) could be more informative.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
One insight from this project is that managing async operations with Swift’s async/await model simplifies the code significantly, compared to older callback-based approaches. It was important to ensure that UI updates occurred on the main thread after network requests, which was easily handled by using @MainActor in the ViewModel.

# Features
1. Fetches recipes from a network service
2. Displays a list of recipes, including their name and cuisine
3. Caches images locally for faster loading
4. Supports handling of loading states and error messages
5. Allows cleaning of old cached images

# Technologies Used
1. Swift 5
2. SwiftUI
3. Swift Concurrency: Async/Await for asynchronous operation
4. UIKit (for handling images and other UI components)
5. Custom Image Caching
   
# Supported Versions
iOS 16 and above

# Project Structure
1. Model: Contains the data structures (e.g., Recipe) and networking logic (e.g., RecipeService).
2. ViewModel: Implements the business logic for the Recipes view (e.g., RecipesViewModel).
3. View: The UI elements, built with SwiftUI (e.g., RecipeCardView).
4. Helpers: Contains helper classes such as the image caching related clases (ImageLoader, ImageCache, DiskCache).

# Setup Instructions
1. Clone Repository:
   git clone https://github.com/gonzalobarrios/recipes-app.git
2. Open in Xcode:
   open Recipes.xcodeproj
3. Build and run the app in the simulator or on a physical device.

# Testing
1. Unit tests are written for key components, including the RecipesViewModel.
2. UI tests are included for core views like the recipe list.

To run the tests, simply select the Test target in Xcode and run the tests.




