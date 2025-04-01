# ThiruVazhi - A Traditionally Inspired Thirukkural App

## Overview
ThiruVazhi is a culturally inspired Thirukkural app that digitally presents the ancient wisdom of 1,330 couplets, originally preserved in palm leaf manuscripts (Olaichuvadi) by Thiruvalluvar. The app features a traditionally inspired UI/UX, allowing users to explore chapters, themes, and translations of Thirukkurals in a user-friendly and searchable format while preserving Tamil’s cultural heritage.

## UI/UX Design
The Kural card and chapter card designs replicate the aesthetic of palm leaf manuscripts. SwiftUI was used for these designs due to its declarative UI syntax and state management capabilities. The app stores user preferences for showing or hiding Tamil text using UserDefaults from the Foundation framework, ensuring persistence.

## Features

![Simulator Screenshot - iPhone 16 Pro - 2025-04-01 at 23 47 00](https://github.com/user-attachments/assets/7a9cd46d-6ea8-4645-af09-91b7ad695c21)

### Home Menu
- **Thirukkural of the Day**: Iterates through all 1,330 Kurals daily.
- **Random Thirukkural Generator**: Displays a random Kural when the user taps "Generate New Thirukkural".
- **History Card**: Provides a brief history of Thirukkural with a "Read More" option.
- **State Management**: Uses Combine for publishing changes to the Kural card.

![Simulator Screenshot - iPhone 16 Pro - 2025-04-01 at 23 47 11](https://github.com/user-attachments/assets/24455084-1fff-47c9-80ca-8b37ef52c6a9)

### Chapters Menu
- Displays all 133 chapters.
- Users can filter chapters by the books they belong to.
- Users can search for a chapter by entering its name or number.
- Implements LazyVGrid for displaying chapter cards efficiently.

![Simulator Screenshot - iPhone 16 Pro - 2025-04-01 at 23 47 22](https://github.com/user-attachments/assets/8e75a547-17eb-4485-b93c-c5c863333e11)

### Explore Menu
- Contains **8 Themes**, each grouping Thirukkurals relevant to the theme.
- Lists **10 Famous Thirukkurals**, commonly heard in Tamil Nadu.
- Uses **Foundation** to decode Kural and chapter details from a JSON file.
- **Search Bar**:
  - Users can search for a Thirukkural by number, translation, or meaning.
  - The JSON file consists of over 17,000 lines of data, causing initial performance issues.
  - To resolve lagging, a **preloaded search index** was implemented, combining translation and explanations in lowercase.
  - Uses **debouncing with DispatchWorkItem (0.3s delay)** to prevent excessive searches on every keystroke.
  - Limits search results to 50 items for performance optimization.
  - Displays a progress view if results take longer to load.

![Simulator Screenshot - iPhone 16 Pro - 2025-04-01 at 23 48 43](https://github.com/user-attachments/assets/d866c834-048c-469e-854f-39a8d54584de)

### Favorites Menu
- Displays all the Kural cards and chapter cards that have been marked as favorites by the user.
