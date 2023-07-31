*** Settings ***

Documentation     Just a RobotFramework script to regularize attendance in Keka - The HR payroll Softwar
Variables         keka.py
Library           SeleniumLibrary
Suite Setup       Keka Setup
Suite Teardown    Keka Teardown


*** Variables ***

${FIELD_EMAIL}=            id:email
${FIELD_PASSWORD}=         id:password
${LOADER}=                 id:loader
${SPINNER}=                id:spinner
${REGULARIZE_DROPDOWN}=    xpath://span[@tooltip="Absent"]
${LOGIN_BUTTON}=           xpath:/html/body/div/div[2]/div[1]/div[2]/form/div/button
${NAVBAR_ME}=              xpath://*[@id="accordion"]/li[2]/a/span[2]
${ATTENDANCE_TAB}=         xpath://*[@id="preload"]/xhr-app-root/div/employee-me/div/ul/li[2]/a
${REGULARIZE_BUTTON}=      xpath://a[contains(text(), "Regularize")]
${REQUEST_BUTTON}=         xpath://button[contains(text(), "Request")]
${ADD_LOG_BUTTON}=         xpath://button[contains(text(), "+Add Log")]
${TIME_INPUT_IN}=          xpath://input[@formcontrolname="inTimestamp"]
${TIME_INPUT_OUT}=         xpath://input[@formcontrolname="outTimestamp"]
${NOTE_INPUT}=             xpath://textarea[@formcontrolname="note"]

*** Tasks ***

Regularize Attendance In Keka
    Login Into Keka
    Run Keyword And Continue On Failure    Wait and check if captcha is requested
    Goto Attendance Page
    Regularize For Every Single Day


*** Keywords ***

Wait Until Spinner Stops
    Wait Until Page Does Not Contain Element    ${LOADER}
    Wait Until Page Does Not Contain Element    ${SPINNER}
    Sleep    1s

Wait and check if captcha is requested
    # Sleep    30s
    Input Password    ${FIELD_PASSWORD}    ${KEKA_PASSWORD}
    # Click Button    ${LOGIN_BUTTON}

Login Into Keka
    Open Browser    ${KEKA_DOMAIN}    browser=googlechrome
    Wait Until Spinner Stops
    Input Text    ${FIELD_EMAIL}    ${KEKA_EMAIL}
    Input Password    ${FIELD_PASSWORD}    ${KEKA_PASSWORD}
    Click Button    ${LOGIN_BUTTON}

Goto Attendance Page
    Wait Until Page Contains Element    ${NAVBAR_ME}    timeout=60s
    Wait Until Spinner Stops
    Click Element    ${NAVBAR_ME}
    Wait Until Spinner Stops
    Click Element    ${ATTENDANCE_TAB}

Regularize For Every Single Day
    Wait Until Spinner Stops
    Wait Until Element Is Visible    ${REGULARIZE_DROPDOWN}
    ${COUNT}=    Get Element Count    ${REGULARIZE_DROPDOWN}
    Repeat Keyword    ${COUNT}    Regularize Attendance

Regularize Attendance
    ${ELEMENT}=    Get WebElement    ${REGULARIZE_DROPDOWN}
    Click Element    ${ELEMENT}
    ${ELEMENT}=    Get WebElement    ${REGULARIZE_BUTTON}
    Click Element    ${ELEMENT}
    Wait Until Element Is Visible    ${REQUEST_BUTTON}
    Click Element    ${ADD_LOG_BUTTON}
    Input Text    ${TIME_INPUT_IN}    ${KEKA_TIME_IN}
    Input Text    ${TIME_INPUT_OUT}    ${KEKA_TIME_OUT}
    Input Text    ${NOTE_INPUT}    ${KEKA_NOTE}
    Click Button    ${REQUEST_BUTTON}
    Wait Until Spinner Stops
    Capture Page Screenshot

Keka Setup
    Set Selenium Timeout    30s

Keka TearDown
    Close All Browsers
