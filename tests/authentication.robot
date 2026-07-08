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
${NO_RESET}           true

*** Test Cases ***
Launch App And Click Login Using OS System
    Open Application
    ...    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:udid=${UDID}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:noReset=${NO_RESET}

    # Wait for the login button to ensure the screen is fully loaded
    Wait Until Page Contains Element    accessibility_id=Login    timeout=20s
    
    # Wait 3 seconds for the UI animation to completely settle
    Sleep    3s
    
    # Use Python's built-in OS module to execute the exact CMD string
    Evaluate    os.system('adb -s ${UDID} shell input tap 540 2095')    modules=os

    # Wait 5 seconds to observe the screen transition
    Sleep    5s

    Close Application