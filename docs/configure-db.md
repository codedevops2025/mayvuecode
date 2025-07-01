## Add Certificates
    Open Run → type mmc → press Enter.
    In the console, go to File → Add/Remove Snap-in.
    Select Certificates → click Add → choose Computer account → Finish → OK.
    In the tree:
        Under Personal → Certificates:
            Right-click Certificates → All Tasks → Import → import the SSL certificate (mayvuehosting, mayvuehostingdev, mayvuehostinguat).
        Under Trusted Root Certification Authorities → Certificates:
            Right-click Certificates → All Tasks → Import → import the certificate authority file (ca.pem).

## Configure IIS Binding
    Open IIS Manager.
    Expand the Sites node and select Default Web Site.
    In the right pane, click Bindings → click Add:
        Type: https
        IP address: All Unassigned
        Port: 443
        Hostname: your application DNS (e.g. brm-alpha-prod.mayvuehostingdev.com)
        SSL certificate: select the correct one from the dropdown.
    Click OK and then Close.

## Connect to SQL Server
    Open SQL Server Management Studio (SSMS).
    Server name: RDS endpoint (from AWS).
    Authentication: SQL Server Authentication.
    Login/Password: from your RDS setup.
    Optional: check Trust Server Certificate if needed.

## Create the Database
    In SSMS, right-click Databases → New Database.
    Name it: FutureSerenity, or use your own.
    Alternatively, run the setup script:
        Go to File → Open → File... and select upgrade.sqlserver.sql.
        Click Execute.
    Ensure no errors during execution.

## Initialize Application Table
    Replace all URLs with your actual DNS, if different.

-- Newman
UPDATE Application 
SET PostLogoutRedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/"]' 
WHERE DisplayName = 'Newman';

-- Serenity API
UPDATE Application 
SET PostLogoutRedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/signout-callback-oidc"]' 
WHERE DisplayName = 'Serenity API';

-- Serenity SPA
UPDATE Application 
SET PostLogoutRedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/signout-callback-oidc"]' 
WHERE DisplayName = 'Serenity SPA';

-- Swagger
UPDATE Application 
SET PostLogoutRedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/"]' 
WHERE DisplayName = 'Swagger';

-- Newman
UPDATE Application 
SET RedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/signin-oidc"]' 
WHERE DisplayName = 'Newman';

-- Serenity API
UPDATE Application 
SET RedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/callback", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/silent-renew.html", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/api/oauth2-redirect.html"]' 
WHERE DisplayName = 'Serenity API';

-- Serenity SPA
UPDATE Application 
SET RedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/callback", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/silent-renew.html", "https://brm-alpha-prod.mayvuehostingdev.com/BrM7/api/oauth2-redirect.html"]' 
WHERE DisplayName = 'Serenity SPA';

-- Swagger
UPDATE Application 
SET RedirectUrisJson = '["https://brm-alpha-prod.mayvuehostingdev.com/BrM7/api/oauth2-redirect.html"]' 
WHERE DisplayName = 'Swagger';

## Register BrM7 Task Service
Open Command Prompt as Administrator and run:
sc create BrM7TaskService binPath= "C:\BrM7Websites\TaskService\TaskService.exe" start= auto

## Reset IIS
iisreset

## Refresh in IIS
    Open IIS Manager.
    Right-click Default Web Site → click Refresh.
    Select the site and click Restart in the right pane.

## Launch Application
    Open a browser.
    Go to: https://brm-alpha-prod.mayvuehostingdev.com/BrM7
    Verify login, redirects, and API are working.
