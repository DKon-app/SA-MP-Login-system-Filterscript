#include <a_samp>
#include <a_http>

// Define constants for user interaction
#define CMD_LOGIN "login"

// Function prototypes
forward OnLoginSuccess(playerid, token[], accountId[]);
forward OnLoginFailure(playerid);

// The main script
public OnGameModeInit() {
    print("Filterscript for DKon authentication loaded.");
}

// Command to initiate login process
public OnPlayerCommandText(playerid, cmdtext[]) {
    if(strcmp(cmdtext, CMD_LOGIN, true) == 0) {
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,
                         "Login", "Enter username and password:",
                         "Login", "Cancel");
        return 1;
    }
    return 0;
}

// Handle dialog responses
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid == DIALOG_LOGIN) {
        if(response) {
            // Split the input as username and password
            new username[32], password[32];
            sscanf(inputtext, "{s} {s}", username, password);

            // Call function to authenticate
            AuthenticateUser(playerid, username, password);
        }
    }
    return 1;
}

// Function to authenticate the user
function AuthenticateUser(playerid, username[], password[]) {
    new url[128];
    format(url, sizeof(url), "https://api.dkon.app/api/v3/method/account.signIn");

    // Create JSON object for the request
    new JsonData[256];
    format(JsonData, sizeof(JsonData), "{\"clientId\":\"1302\", \"username\":\"%s\", \"password\":\"%s\"}", username, password);

    // Send the request
    SendHttpRequest(url, JsonData, playerid);
}

// Handle HTTP requests
public OnHttpResponse(playerid, response[]) {
    // Parse the 'response' JSON
    new accessToken[128], accountId[32];
    if (json_exists(response, "error") && json_get_int(response, "error_code") != 0) {
        OnLoginFailure(playerid);
    } else {
        json_get_string(response, "accessToken", accessToken, sizeof(accessToken));
        json_get_string(response, "accountId", accountId, sizeof(accountId));
        OnLoginSuccess(playerid, accessToken, accountId);
    }
}

// Callback for successful login
forward OnLoginSuccess(playerid, token[], accountId[]) {
    // Store the token or handle login success
    SendClientMessage(playerid, COLOR_GREEN, "Login successful!");
    return 1; 
}

// Callback for failed login
forward OnLoginFailure(playerid) {
    SendClientMessage(playerid, COLOR_RED, "Login failed. Please check your credentials.");
    return 1;
}
