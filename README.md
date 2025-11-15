# SA:MP DKon Authentication Filterscript

This Filterscript allows you to integrate user authentication into your SA:MP server using the DKon API. Players can log in using their credentials, and the script handles the process of communicating with the API for authentication.

## Features

- Player login via username and password.
- Integration with the DKon API for authentication.
- Feedback messages for players (success or failure).
- Simple interface for entering login credentials.

## Installation

1. **Download the Filterscript**:
   Save the provided code into a file named `dkon_auth.pwn`.

2. **Compile the Script**:
   Use the Pawn compiler (e.g., `pawno`) to compile the script into an `.amx` file.

3. **Place the Compiled File**:
   Move the compiled `dkon_auth.amx` file into your SA:MP server's `filterscripts` folder.

4. **Update Server Configuration**:
   Open `server.cfg` and add the following line to the `filterscripts` section: filterscripts dkon_auth


   
5. **Restart Your Server**:
Restart your SA:MP server for the changes to take effect.

## Usage

- Players can type `/login` to trigger the login dialog.
- They will need to enter their username and password to authenticate.

## Registration Site

You can register an account at [DKon.app](https://dkon.app) to obtain your API credentials and test the login functionality.

## Notes

- Ensure that you have included the necessary `a_samp` and `a_http` includes in your Pawn environment.
- Test the functionality thoroughly to ensure that it works as intended with your server setup.

