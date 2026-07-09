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
Verify User Can Complete Forgot Password Flow Successfully
    Open Application
    ...    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:udid=${UDID}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:noReset=${NO_RESET}

    # Step 1: Click the initial Login button to reach the credentials screen
    Wait Until Page Contains Element    accessibility_id=Login    timeout=20s
    Click Element                       accessibility_id=Login

    Sleep    4s

    # Step 2: Click the 'Forgot Password ?' link
    Wait Until Page Contains Element    xpath=//android.view.View[@content-desc="Forgot Password ?"]    timeout=15s
    Click Element                       xpath=//android.view.View[@content-desc="Forgot Password ?"]

    Sleep    4s

    # Step 3: Input email into the Email/Phone text field
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="Email/Phone_text_field"]    timeout=15s
    Click Element                       xpath=//android.widget.EditText[@resource-id="Email/Phone_text_field"]
    Input Text                          xpath=//android.widget.EditText[@resource-id="Email/Phone_text_field"]    testershrig@gmail.com

    Hide Keyboard
    Sleep    2s

    # Step 4: Click the Continue button
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Continue_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Continue_button"]/android.widget.Button

    Sleep    5s

    # Step 5: Wait for the OTP page description to fully load
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="otp_description_text"]    timeout=20s

    # -------------------------------------------------------------------------------
    # MANUAL PAUSE: Type the OTP from your email into your phone now!
    # -------------------------------------------------------------------------------
    Sleep    25s    

    # Step 6: Click the Verify button after typing OTP
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Verify_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Verify_button"]/android.widget.Button

    Sleep    5s
    Hide Keyboard
    Sleep    1s

    # Step 7: Target and Input New Password 
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="New Password_text_field"]    timeout=15s
    Click Element                       xpath=//android.widget.EditText[@resource-id="New Password_text_field"]
    Sleep    1s
    Input Text                          xpath=//android.widget.EditText[@resource-id="New Password_text_field"]    Test@123
    
    Hide Keyboard
    Sleep    1s

    # Step 8: Target and Input Confirm New Password 
    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="Confirm New Password_text_field"]    timeout=15s
    Click Element                       xpath=//android.widget.EditText[@resource-id="Confirm New Password_text_field"]
    Sleep    1s
    Input Text                          xpath=//android.widget.EditText[@resource-id="Confirm New Password_text_field"]    Test@123
    
    Hide Keyboard
    Sleep    2s

    # Step 9: Click the Save button to apply new password
    Wait Until Page Contains Element    xpath=//android.view.View[@resource-id="Save_button"]/android.widget.Button    timeout=10s
    Click Element                       xpath=//android.view.View[@resource-id="Save_button"]/android.widget.Button

    Sleep    7s
    Close Application