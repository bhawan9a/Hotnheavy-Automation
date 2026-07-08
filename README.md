# 🚀 Hotnheavy Automation Framework

This repository contains the automated test scripts for the Hotnheavy mobile application. The framework is built using "Robot Framework" and "Appium" to ensure the reliability and stability of the app's core functionalities.

## 📁 Project Structure

- `tests/` : Contains all the test suites (e.g., `authentication.robot`).
- `resources/` : Contains reusable keywords and variables.

---

## 🛠️ How to Run the Tests

You can run the tests directly from the terminal (Git Bash or PowerShell) using the following commands:

1. Run all test cases in a file:
   `robot tests/authentication.robot`

2. Run a specific test case only:
   `robot -t "Verify User Can Login Successfully" tests/authentication.robot`
