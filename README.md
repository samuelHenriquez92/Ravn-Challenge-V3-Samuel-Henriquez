# Ravn-Challenge-V3-Samuel-Henriquez

The challenge consists to show pokemons list with basic information for every generation (up to 8th), also is possible to search them.

## Tech Overview

- [Swift v5](https://developer.apple.com/swift/)
- [SwiftUI v3](https://developer.apple.com/documentation/swiftui/)
- [Combine](https://developer.apple.com/documentation/combine)
- [Apollo](https://github.com/apollographql/apollo-ios)
- MVVM as architecture
- ViewModels provide the information to the view
- Services provide the data to the ViewModel
- The application use SPM (Swift Package Manager) as its dependency manager
- The Application detects when some change occurs in Network connection
- Consume content from the [GraphQL API](https://dex-server.herokuapp.com/)

## Setup/Running Instructions

Requirements

* Xcode 13+
* iOS 15+

Common setup

* Clone the repo.
```bash
git clone https://github.com/samuelHenriquez92/Ravn-Challenge-V3-Samuel-Henriquez.git
```
* Wait until Xcode fetch Apollo dependency.
* Run it in an iOS simulator or a physical device.

## Preview

- Dark Mode/Spanish
<img src="https://github.com/samuelHenriquez92/Ravn-Challenge-V3-Samuel-Henriquez/blob/909fb8295da222c9e84db6f301ab515de6caa2c7/Preview/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-04%20at%2007.59.22.png" alt=""/>

- Light Mode/English
<img src="https://github.com/samuelHenriquez92/Ravn-Challenge-V3-Samuel-Henriquez/blob/909fb8295da222c9e84db6f301ab515de6caa2c7/Preview/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-04%20at%2008.00.05.png" alt=""/>

- Searching
<img src="https://github.com/samuelHenriquez92/Ravn-Challenge-V3-Samuel-Henriquez/blob/909fb8295da222c9e84db6f301ab515de6caa2c7/Preview/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-04%20at%2008.00.54.png" alt=""/>

- No Internet Connection
<img src="https://github.com/samuelHenriquez92/Ravn-Challenge-V3-Samuel-Henriquez/blob/909fb8295da222c9e84db6f301ab515de6caa2c7/Preview/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-04%20at%2008.01.44.png" alt=""/>
