# Poultry Farm Management System Mobile Application

## Project Overview

The **Poultry Farm Management System Mobile Application** is a dedicated mobile application designed to empower poultry farm managers, specifically at First Manna Poultry Farm, by streamlining the management of egg production and sales. This project aims to transition from traditional, manual data collection methods to a modern, digital system, addressing challenges such as rising operational costs, disease threats, and inefficiencies in data handling. By providing a robust platform for data entry, inventory management, sales tracking, and performance analytics, the app seeks to enhance operational efficiency, improve decision-making, and contribute to the farm's overall profitability and sustainability.

## Features

The Poultry Farm Management System Mobile Application app offers a comprehensive suite of features to manage key aspects of poultry farm operations:

* **Interactive Dashboard/Home:** Provides a real-time overview of daily egg production, total sales, and recent sales activities.
* **Egg Production Tracking:** Allows manual input of daily egg collection data, categorized by date, layer house, and quantity.
* **Egg Inventory Management:** Facilitates precise management of egg stock (e.g., Large, Medium, Small, Jumbo) with functionalities to add or remove quantities.
* **Sales Recording:** Enables detailed logging of sales transactions, including sale date, egg type, quantity, and price per piece.
* **Statistics & Reports:** Generates visual charts and reports for egg production trends and total sales performance over various periods (daily, weekly, monthly).
* **About Section:** Provides information about the application.
* **Responsive Navigation:** Intuitive menu bar and bottom navigation icons for seamless access to all app sections.

## Technologies Used

* **Frontend:** Dart, Flutter
* **Backend/Database:** (Placeholder - e.g., Firebase Firestore, Node.js, Python/Django)
* **Diagramming:** Mermaid.js (for rendering diagrams in Markdown)

## Usage

The app is designed for farm personnel to easily manage daily operations:

1.  **Launch the App:** Tap the app icon on your mobile device.
2.  **Navigate:** Use the bottom navigation bar to switch between Dashboard, Egg Production, Sales, Inventory, and Statistics. Use the top-left menu icon to access Profile and About sections.
3.  **Input Data:** Go to "Egg Production," "Sales," or "Inventory" pages to manually enter relevant daily records.
4.  **Monitor Performance:** Visit the "Dashboard" for a quick overview or "Statistics" for detailed charts and reports.

## Agile Development Model

This project follows an Agile development approach, emphasizing iterative development, flexibility, and continuous feedback. The key phases include:

* **System Requirements:** Gathering and defining all necessary features and functionalities for the app.
* **System Design:** Creating the architectural and user interface blueprints for the application.
* **System Development:** Coding and building the app's features in iterative cycles.
* **System Testing:** Rigorously testing developed modules to identify and fix bugs, ensuring functionality and reliability.
* **System Deployment & Maintenance:** Releasing the app to users and providing ongoing support, updates, and feature enhancements.

## User Acceptance Testing (UAT)

User Acceptance Testing (UAT) was conducted to evaluate whether the Egg & Sales Tracker mobile application meets the expected requirements for managing egg production and sales, and functions correctly when used by its intended farm personnel. The objective is to ensure that the application is usable, accurate in its data handling, and ready for deployment in real-world poultry farm operations.

Below are some of the key test cases executed during UAT:

| Test Case | Description | Expected Result | Actual Result | Status |
| :-------- | :---------- | :-------------- | :------------ | :----- |
| UAT-001   | **Record Egg Production** | User successfully inputs egg production data (Date, Layer House, Eggs Collected), and the data is saved and reflected in the system. | Data entered correctly; Production count updated on Dashboard. | ✅ Passed |
| UAT-002   | **Record Sales** | User successfully inputs sales data (Sale Date, Egg Type, Quantity, Per Price Piece), and the data is saved and reflected in the system. | Sales data entered correctly; Sales figures updated on Dashboard/Statistics. | ✅ Passed |
| UAT-003   | **Manage Egg Inventory (Add Stock)** | User successfully adds a specified quantity of a selected egg type to inventory, and the inventory count is updated correctly. | Inventory updated as expected for the selected egg type. | ✅ Passed |
| UAT-004   | **View Egg Production Statistics** | The Statistics page loads correctly, displaying accurate charts/reports for egg production trends (e.g., daily, weekly, monthly). | Statistics page loaded; Charts accurately reflected production data. | ✅ Passed |
| UAT-005   | **View Dashboard Content** | The Dashboard/Home page loads correctly, displaying up-to-date summary metrics and recent sales overview. | Dashboard loaded correctly; All summary metrics and recent sales data were accurate. | ✅ Passed |

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.
