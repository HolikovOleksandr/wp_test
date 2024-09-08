# Documentation for the "Shortest Path Calculation" Application

## Overview

This Flutter application calculates the shortest path between two points on a square grid. It includes functionalities for entering a base URL, showing the execution process, and displaying results.

## Interfaces

### 1. Base URL Input Interface

**Description:**

- **Input Field:** Enter the API URL with GET parameters.
- **Button: Start:** Saves the URL and sends a request. Displays an error message for invalid URLs.

### 2. Execution Process Display Interface

**Description:**

- **Progress Indicator:** Shows task completion percentage.
- **Button: Send Results to Server:** Sends calculation results to the API. Disabled with a loader during the request. Enables and displays an error message if the request fails.

### 3. Results List Display Interface

**Description:**

- Displays each result as a shortest path. Clicking on a result leads to the detailed result interface.

### 4. Detailed Result View Interface

**Description:**

- Shows the shortest path and a grid with:
  - Start Cell: `#64FFDA`
  - End Cell: `#009688`
  - Blocked Cell: `#000000`
  - Shortest Path Cell: `#4CAF50`
  - Empty Cell: `#FFFFFF`

## Shortest Path Calculation

**Description:**

- Computes the shortest path on a grid with `.` and `X` cells. The piece can move in any direction until it hits a blocked cell or the grid edge.
- **Output:** Array of coordinate objects indicating the shortest path. Requires OOP principles and does not allow pre-built solutions.

**Constraints:**

- Grid length > 1 and < 100.
- Start and end coordinates are within the grid.
- Must use OOP.
