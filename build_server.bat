@echo off

:: root directory in which server code is located
set home=E:\games\dayz_source\DayZ\server

:: location of bohemia tools
set tools=E:\games\dayz_source\DayZ\BITools

:: location of the key files
set keyFiles=E:\games\dayz_source\DayZ\keys

:: location to deploy the server files
set serverDeploy=E:\games\dayz\servers\vanilla

:: the name of the directory into which the server PBOs will be placed
set serverName=DayZ_Server


::=================================================================================::
:: stop running server
:: note: service created on Windows 7 using NSSM
:: also had to add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\LocalAccountTokenFilterPolicy = 1
sc \\192.168.56.101 stop dayz-vanilla

mkdir %serverDeploy%\@%serverName%\addons

copy %home%\* %serverDeploy%\@%serverName%

%tools%\cpbo.exe -y -p %home%\PBOs\dayz_server %serverDeploy%\@%serverName%\addons\dayz_server.pbo

:: binaries
xcopy %home%\binaries %ServerDeploy% /E /I /Y

:: mission file
xcopy %home%\MPMissions\dayz_Mod.chernarus %serverDeploy%\MPMissions /E /I /Y

:: profile
xcopy %home%\profile %serverDeploy%\profile /E /I /Y

:: restart server
sc \\192.168.56.101 start dayz-vanilla