*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}         http://127.0.0.1:4723
${PLATFORM_NAME}      Android
${AUTOMATION_NAME}    UiAutomator2
${DEVICE_NAME}        Android
${UDID}               89ee545e
${APP_PACKAGE}        com.hotnheavy.HOTNHEAVY
${APP_ACTIVITY}       com.hotnheavy.HOTNHEAVY.MainActivity
${NO_RESET}           false

*** Test Cases ***
Verify User Can Login Successfully
    Open Application
    ...    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:udid=${UDID}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:noReset=${NO_RESET}

    # Step 1: Click the Login button on the initial landing screen
    Wait Until Page Contains Element    accessibility_id=Login    timeout=20s
    Click Element                       accessibility_id=Login

    Sleep    5s

    # Step 2: Target the Email text field using strict XPath
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="Email_text_field"]    timeout=20s
    Input Text                          xpath=//android.widget.EditText[@resource-id="Email_text_field"]    testershrig@gmail.com
    
    Hide Keyboard
    Sleep    1s

    # Step 3: Target the Password text field, click it to gain focus, then input
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="Password_text_field"]    timeout=15s
    Click Element                       xpath=//android.widget.EditText[@resource-id="Password_text_field"]
    Input Password                      xpath=//android.widget.EditText[@resource-id="Password_text_field"]    Test@123
    
    Hide Keyboard
    Sleep    2s

    # Step 4: Click the main Login submit button
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Login_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Login_button"]/android.widget.Button
    
    # Step 5: Handle System Notification Permission Pop-up (Click Allow)
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]    timeout=15s
    Click Element                       xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]

    Sleep    7s
    Close Application

Verify User Email Validation On Join
    Open Application
    ...    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:udid=${UDID}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:noReset=${NO_RESET}

    # Step 1: Click the initial "Join" button on the landing page(For already joined user email)
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Join_button"]/android.widget.Button    timeout=20s
    Click Element                       xpath=//android.view.View[@resource-id="Join_button"]/android.widget.Button

    Sleep    4s

    # Step 2: Target the exact Email field and input the static email for QA validation
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="user@gmail.com_text_field"]    timeout=20s
    Click Element                       xpath=//android.widget.EditText[@resource-id="user@gmail.com_text_field"]
    Input Text                          xpath=//android.widget.EditText[@resource-id="user@gmail.com_text_field"]    testershrig@gmail.com
    
    # Hide keyboard to ensure the "Next" button is visible
    Hide Keyboard
    Sleep    2s

    # Step 3: Click the "Next" button to trigger the app's validation
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button
    
    # Wait to observe the validation error or transition
    Sleep    7s
    Close Application