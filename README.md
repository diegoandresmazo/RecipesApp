# RecipeApp
Recipe Application Challenge using spoonacular API

## `Execution Guide`
1. git clone git@github.com:diegoandresmazo/RecipesApp.git
2. cd RecipesApp
3. open RecipesApp.xcodeproj

## `Environment Stack`
- iOS SDK 15
- Swift 5.0
- Xcode 14.1
- Xcode 13.0-compatible 

## `Architecture`
The application uses Swift MVVM Architecture, utilizing Combine to make API calls and SwiftUI to make the Views.

 [Reference to Swift MVVM](https://www.maray.ai/posts/swift-mvvm-architecture)

 ### Architecture Diagram:
 <img width="1544" alt="imageMVVM" src="https://user-images.githubusercontent.com/10929423/199441511-c549f33e-76f8-4496-91e5-6c675bd9ba72.png">
 
 The Recipe App created is separated in 4 parts:
 
 1. Networking: responsible for making the connection with the API. 
 2. Model: The Data folder contains the Entities Models (Recipe and RecipeDetail).
 3. View: Composed by the Views of the application created in SwiftUI.
 4. ViewModels: In charge of having the logic and the connection between the View and the Model.

## `Design Patterns & Good Programming Practices` 
  * SOLID Principles.
  * Architecture designed for the use of dependency injection.
  * SwiftUI ViewModifiers.
  * Inheritance.
  * Reused Code.
  * Views by code.
  * Generics.
  * Reactivity.
  * Errors Handler.

## `Drawbacks`
- Repeated code.  
  In general, the UI and the view objects that conform it, had several modifiers in common that caused the code to be constantly repeated. To improve this, some ViewModifiers were made by reusing the code and centralizing the view modifiers in a better way that allow better unification of the design.
