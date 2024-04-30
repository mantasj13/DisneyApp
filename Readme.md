# Disney App

### Development Environment:
 - Development Environment: Xcode 15.3
 - Minimum Target: iOS 17.

### Architecture 
- I've adopted the MVVM pattern to enhance the readability, maintainability, scalability, and testability of the iOS application. To facilitate this, I used the @Published property wrapper, allowing SwiftUI to automatically refresh the necessary components when the state changes. Additionally, I've integrated the async/await paradigm into networking operations, enhancing the efficiency and responsiveness of the application. Used @AppStorage property wrapper to save the favourite characters, simplifies the process of reading and writing data to UserDefaults and automatically updates your view whenever the stored value changes. The favourites characters are sorted by numbers of films.

### Layers
- ViewModel: Business layer
- Service layer: Handles the interaction with external services and APIs.
- Network layer: Utilises Swift's URLSession for network operations

### Testing
- Unit tests were added to test the behavior of the application.

### The UI
- The design is intentionally kept simple with default fonts, and sizes.
