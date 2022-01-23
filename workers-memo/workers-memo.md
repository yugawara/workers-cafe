# Workers' Memo

## Cypress Installation

> Installation **<span style="color:red">Failed</span>** in GUIX OS, probably due to lack of dependencies 

In Windows 10, just following the standard instructions were not enough. The following had to be executed.
```powershell
.\node_modules\.bin\cypress.cmd install --force
$env:NODE_OPTIONS="--openssl-legacy-provider" 
```
> To permanently modify environmental variable:
> ```Powershell
> rundll32.exe sysdm.cpl,EditEnvironmentVariables.
> ```
![](2022-01-22-20-50-37.png)

The overall impression of Cypress, based on the rather poor installation
exerience, is not that great.  It is what it is...
Maybe one should try the new Playwright from Microsoft?  (The author
has never tried it before though...)