*** Settings ***
Library    AppiumLibrary

*** Variables ***
${APPIUM_SERVER}          http://127.0.0.1:4723
${APP_PACKAGE}            com.hotnheavy.HOTNHEAVY
${APP_ACTIVITY}           .MainActivity

# Radio card on Home screen
${RADIO_CARD}             xpath=//android.widget.ImageView[contains(@content-desc,"Radio")]

# play/stop button inside the radio player - no id/content-desc, bounds only
${RADIO_PLAY_BUTTON}      xpath=//android.view.View[@bounds="[461,1725][619,1882]"]

# 3-dot menu on the radio player - using exact bounds instead of resource-id,
# since "more_button" is reused for Home's own top-bar menu too, which can
# still exist underneath the radio player sheet and get clicked by mistake
${RADIO_MORE_BUTTON}      xpath=//android.widget.Button[@bounds="[957,1260][1021,1325]"]

# options inside the 3-dot menu popup
${MENU_FAVORITES}         accessibility_id=Favorites
${MENU_SAVE}              accessibility_id=Save
${MENU_ADD_TO_PLAYLIST}   accessibility_id=Add to Playlist
${MENU_GO_TO_ARTISTS}     accessibility_id=Go to Artists

# name of the existing playlist to add the song to
${EXISTING_PLAYLIST}      Road Music

*** Test Cases ***
Play Radio Card
    [Teardown]    Close Application
    Open App
    Go To Home
    Play Radio

    # let it play for a bit
    Sleep    10s

    Close Radio Player

Radio Favorite Playlist And Artist Flow
    [Teardown]    Close Application
    Open App
    Go To Home

    # first pass - mark as favorite, then add to an existing playlist
    Play Radio
    Mark As Favorite
    Add To Existing Playlist    ${EXISTING_PLAYLIST}

    # adding to a playlist takes us back to home automatically (toast shows,
    # then it navigates on its own) - just wait for home to be back
    Wait Until Element Is Visible    ${RADIO_CARD}    timeout=10s

    # second pass - play again and go to the artist page instead
    Play Radio
    Go To Artists From Radio

*** Keywords ***
Open App
    Open Application    ${APPIUM_SERVER}
    ...    automationName=UIAutomator2
    ...    platformName=Android
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    noReset=true

Go To Home
    # noReset=true means the app resumes on whatever screen the last run
    # left off on, not fresh at Home, so press back a few times until the
    # radio card actually shows up before doing anything else
    FOR    ${i}    IN RANGE    4
        ${visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${RADIO_CARD}    timeout=2s
        Exit For Loop If    ${visible}
        Go Back
        Sleep    500ms
    END
    Wait Until Element Is Visible    ${RADIO_CARD}    timeout=10s

Play Radio
    # taps the radio card - give it a couple seconds to actually start
    # playing / finish loading before doing anything else
    Wait Until Element Is Visible    ${RADIO_CARD}    timeout=10s
    Click Element    ${RADIO_CARD}
    Sleep    3s

Open Radio Menu
    Wait Until Element Is Visible    ${RADIO_MORE_BUTTON}    timeout=10s
    Click Element    ${RADIO_MORE_BUTTON}

Mark As Favorite
    Open Radio Menu
    Wait Until Element Is Visible    ${MENU_FAVORITES}    timeout=5s
    Click Element    ${MENU_FAVORITES}
    Sleep    2s

Add To Existing Playlist
    # opens the menu, taps Add to Playlist, then picks the playlist by name
    # from the list that shows up
    [Arguments]    ${playlist_name}
    Open Radio Menu
    Wait Until Element Is Visible    ${MENU_ADD_TO_PLAYLIST}    timeout=5s
    Click Element    ${MENU_ADD_TO_PLAYLIST}

    ${playlist_item}=    Set Variable    xpath=//*[@content-desc="${playlist_name}"]
    Wait Until Element Is Visible    ${playlist_item}    timeout=10s
    Click Element    ${playlist_item}
    Sleep    2s

Go To Artists From Radio
    Open Radio Menu
    Wait Until Element Is Visible    ${MENU_GO_TO_ARTISTS}    timeout=5s
    Click Element    ${MENU_GO_TO_ARTISTS}

Close Radio Player
    # swipe down to dismiss the radio player and return to home
    Swipe By Percent    50    20    50    80
    Wait Until Element Is Visible    ${RADIO_CARD}    timeout=10s
