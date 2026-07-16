*** Settings ***
Library    AppiumLibrary

*** Variables ***
${APPIUM_SERVER}          http://127.0.0.1:4723
${APP_PACKAGE}            com.hotnheavy.HOTNHEAVY
${APP_ACTIVITY}           .MainActivity

# home screen
${MENU_BUTTON}            xpath=//android.widget.Button[@resource-id="more_button"]
${UPLOAD_SONG_OPTION}     accessibility_id=Upload Song

# upload form
${AUDIO_UPLOAD_CARD}      xpath=//android.view.View[@resource-id="upload_audio_card"]
${AUDIO_FILE}             xpath=//*[contains(@text, 'zara-zara') or contains(@content-desc, 'zara-zara')]
${SONG_TITLE_INPUT}       xpath=//android.widget.EditText[@resource-id="Add song name_text_field"]

# feature / collaboration
${FEATURE_BUTTON}         accessibility_id=Invite feature artist
${COLLAB_BUTTON}          accessibility_id=Add collaborators...
${SHREE_KRISHNA}          xpath=//android.widget.ImageView[@resource-id="user_profile_https://storage.googleapis.com/friendslikeus-prod/user-uploads/6a3abcf12fea695da2eaa07c/avatar/avatar-1782331496415-143629887.jpg"]
${DONE_BUTTON}            xpath=//android.view.View[contains(@content-desc, 'Done(')]
${DONE_BUTTON_ZERO}       xpath=//android.view.View[@content-desc="Done(0)"]

# genre / upload
${GENRE_ACOUSTIC}         accessibility_id=Acoustic
${UPLOAD_BUTTON}          accessibility_id=Upload

*** Test Cases ***
Upload A Single Song
    [Teardown]    Close Application
    Open App

    # open the upload screen
    Wait Until Element Is Visible    ${MENU_BUTTON}    timeout=15s
    Click Element    ${MENU_BUTTON}
    Sleep    1s
    Wait Until Element Is Visible    ${UPLOAD_SONG_OPTION}    timeout=5s
    Click Element    ${UPLOAD_SONG_OPTION}

    # choose the audio file
    Wait Until Element Is Visible    ${AUDIO_UPLOAD_CARD}    timeout=5s
    Click Element    ${AUDIO_UPLOAD_CARD}
    Sleep    3s
    Swipe By Percent    50    80    50    30
    Sleep    1s
    Swipe By Percent    50    80    50    30
    Wait Until Element Is Visible    ${AUDIO_FILE}    timeout=10s
    Click Element    ${AUDIO_FILE}
    Sleep    2s

    # type the song title
    Wait Until Element Is Visible    ${SONG_TITLE_INPUT}    timeout=10s
    Click Element    ${SONG_TITLE_INPUT}
    Input Text    ${SONG_TITLE_INPUT}    Automation Song
    Hide Keyboard

    # add feature artist
    Scroll To Element    ${FEATURE_BUTTON}
    Click Element    ${FEATURE_BUTTON}
    Pick Collaborator
    Sleep    2s

    # add collaborators
    Scroll To Element    ${COLLAB_BUTTON}
    Click Element    ${COLLAB_BUTTON}
    Pick Collaborator
    Sleep    2s

    # pick genre
    Scroll To Element    ${GENRE_ACOUSTIC}
    Click Element    ${GENRE_ACOUSTIC}

    # upload song
    Wait Until Element Is Visible    ${UPLOAD_BUTTON}    timeout=10s
    Click Element    ${UPLOAD_BUTTON}

*** Keywords ***
Open App
    Open Application    ${APPIUM_SERVER}
    ...    automationName=UIAutomator2
    ...    platformName=Android
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    noReset=true

Scroll To Element
    # just keep swiping down till we can see the element
    # form height changes as we fill stuff in so a fixed swipe count doesn't work
    [Arguments]    ${element}
    FOR    ${i}    IN RANGE    6
        ${found}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        Exit For Loop If    ${found}
        Swipe By Percent    50    70    50    30
        Sleep    500ms
    END
    Wait Until Element Is Visible    ${element}    timeout=5s

Pick Collaborator
    # tap the artist and check if it actually got selected (Done counter changes from 0)
    # sometimes the tap doesn't register, so we tap again by coordinates if that happens
    Wait Until Element Is Visible    ${SHREE_KRISHNA}    timeout=10s
    Click Element    ${SHREE_KRISHNA}

    ${selected}=    Run Keyword And Return Status
    ...    Wait Until Page Does Not Contain Element    ${DONE_BUTTON_ZERO}    timeout=5s

    IF    not ${selected}
        Log    tap didn't work, trying again    console=True
        Click Element    ${SHREE_KRISHNA}
        Wait Until Page Does Not Contain Element    ${DONE_BUTTON_ZERO}    timeout=5s
    END

    Click Element    ${DONE_BUTTON}
