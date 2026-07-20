*** Settings ***
Library    AppiumLibrary

*** Variables ***
${APPIUM_SERVER}          http://127.0.0.1:4723
${APP_PACKAGE}            com.hotnheavy.HOTNHEAVY
${APP_ACTIVITY}           .MainActivity

# bottom nav search icon has no resource-id or content-desc, only bounds -
# this is fragile (breaks if layout shifts) but it's all we have right now
${SEARCH_TAB_ICON}        xpath=//android.widget.ImageView[@bounds="[825,2083][1006,2265]"]

# the search box - matched by element type, not hint text, because the
# hint attribute disappears entirely once the field already has text in it
# (which happens right after coming back from a previous search)
${SEARCH_INPUT}           xpath=//android.widget.EditText

# the small "x" button next to the search box that clears the current text
${SEARCH_CLEAR_BUTTON}    xpath=//android.view.View[@bounds="[772,1321][816,1366]"]

# the in-app back arrow shown on artist/song/album pages - the hardware
# back button (Go Back) doesn't behave the same way in this app, so we
# tap this directly instead
${BACK_ARROW}             xpath=//android.widget.Button[@bounds="[12,119][156,263]"]

*** Test Cases ***
Search Artist Then Song Then Album
    [Teardown]    Close Application
    Open App
    Go To Search Tab
    Type Search Term    Bhavsss

    # open the artist profile
    Open Search Result    Bhavsss    Artist

    # come back from the artist page - this lands directly back on the
    # search results screen, not all the way to Home
    Return To Search Input

    # search a song, wait a bit, then clear it and search an album instead
    Type Search Term    green
    Sleep    5s
    Type Search Term    God
    Open Search Result    God    Album

    # now on the album page - play a specific track from it
    Click By Content Desc    Khamosi

*** Keywords ***
Open App
    Open Application    ${APPIUM_SERVER}
    ...    automationName=UIAutomator2
    ...    platformName=Android
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    noReset=true

Go To Search Tab
    # used right after opening the app - noReset=true means it resumes on
    # whatever screen the last run left off on, not fresh at Home, so press
    # back a few times until the search tab icon actually shows up
    FOR    ${i}    IN RANGE    4
        ${visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${SEARCH_TAB_ICON}    timeout=2s
        Exit For Loop If    ${visible}
        Go Back
        Sleep    500ms
    END
    Wait Until Element Is Visible    ${SEARCH_TAB_ICON}    timeout=10s
    Click Element    ${SEARCH_TAB_ICON}

Return To Search Input
    # used mid-flow after viewing an artist/song/album opened from search
    # results - tap the in-app back arrow (not the hardware back button)
    # to land back on the search results screen
    #
    # retrying the click itself (instead of "wait then click separately")
    # avoids stale element errors if the screen is still settling/animating
    Wait Until Keyword Succeeds    10s    1s
    ...    Click Element    ${BACK_ARROW}

    ${landed}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=10s
    IF    not ${landed}
        Capture Page Screenshot    after_back_arrow.png
        ${src}=    Get Source
        Create File    ${OUTPUT_DIR}/after_back_arrow_source.xml    ${src}
        Fail    Did not land on search input after tapping back arrow - check after_back_arrow.png / after_back_arrow_source.xml
    END

Type Search Term
    # clicks the x button to clear any leftover text from a previous search,

    [Arguments]    ${term}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=10s
    Click Element    ${SEARCH_INPUT}

    ${clear_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${SEARCH_CLEAR_BUTTON}
    IF    ${clear_visible}
        Click Element    ${SEARCH_CLEAR_BUTTON}
    ELSE
        Clear Text    ${SEARCH_INPUT}
    END

    Input Text    ${SEARCH_INPUT}    ${term}

Open Search Result
    # finds a result item whose content-desc matches the search term
    # result_type lets us pick the right row when the same name shows up
    # under multiple rows (e.g. an artist name also appears on all their
    # songs/albums as "Song\n<artist>" / "Album\n<artist>")
    # pass result_type as Song / Album / Artist to disambiguate, or leave
    # empty to just grab the first match
    [Arguments]    ${term}    ${result_type}=${EMPTY}
    IF    "${result_type}" == "${EMPTY}"
        ${result}=    Set Variable    xpath=//*[contains(@content-desc,"${term}")]
    ELSE
        ${result}=    Set Variable    xpath=//*[contains(@content-desc,"${term}") and contains(@content-desc,"${result_type}")]
    END
    Wait Until Element Is Visible    ${result}    timeout=10s
    Click Element    ${result}

Click By Content Desc
    # generic tap-by-label, for things like tapping a song row to play it
    [Arguments]    ${text}
    ${locator}=    Set Variable    xpath=//*[contains(@content-desc,"${text}")]
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Click Element    ${locator}
