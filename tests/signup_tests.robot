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
Verify User Join Flow Step By Step
    Open Application
    ...    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:udid=${UDID}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:noReset=${NO_RESET}

    # Welcome Screen
    Wait Until Page Contains Element    accessibility_id=Join    timeout=20s
    Click Element                       accessibility_id=Join
    Sleep    3s

    # Email Screen
    Wait Until Page Contains Element    xpath=//android.widget.EditText    timeout=15s
    Input Text                          xpath=//android.widget.EditText    testershrig+2@gmail.com
    Click Element                       xpath=//android.widget.Button[@content-desc="Next"]
    Sleep    3s

    # OTP Screen (Manual Pause)
    Sleep    5s    
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="otp_textfield"]    timeout=20s
    Log To Console                      \n*** ENTER OTP MANUALLY NOW ***
    Sleep    20s
    Click Element                       xpath=//android.widget.Button[@content-desc="Next"]
    Sleep    3s

    # Username Screen
    Sleep    3s
    Wait Until Page Contains Element    xpath=//android.widget.EditText    timeout=15s
    Input Text                          xpath=//android.widget.EditText    tester22
    Sleep    2s
    Hide Keyboard
    Sleep    2s
    # Clickable child button inside Next_button wrapper
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button
    Sleep    3s

    # Password Screen
    Sleep    3s
    Wait Until Page Contains Element    xpath=//android.widget.EditText    timeout=15s
    Input Text                          xpath=//android.widget.EditText    Test@123
    Sleep    2s
    Hide Keyboard
    Sleep    2s
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Continue_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Continue_button"]/android.widget.Button
    Sleep    3s

    # Full Name Screen
    Sleep    3s
    Wait Until Page Contains Element    xpath=//android.widget.EditText    timeout=15s
    Input Text                          xpath=//android.widget.EditText    tester2
    Sleep    2s
    Hide Keyboard
    Sleep    2s
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button
    Sleep    3s

    # Date of Birth Screen
    Sleep    3s
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button    timeout=15s
    Click Element                       xpath=//android.view.View[@resource-id="Next_button"]/android.widget.Button
    Sleep    5s