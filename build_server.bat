call constants.bat

::=================================================================================::
:: stop running server
:: note: service created on Windows 7 using NSSM
:: also had to add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\LocalAccountTokenFilterPolicy = 1
:: sc \\192.168.56.101 stop dayz-vanilla

mkdir %serverDeploy%\@%serverName%\addons

:: compile server PBO
%tools%\cpbo.exe -y -p %serverSource%\PBOs\dayz_server %serverDeploy%\@%serverName%\addons\dayz_server.pbo

:: copy key for verifying client PBO
copy %keyFiles%\%modName%.bikey %serverDeploy%\%modName%.bikey

:: binaries
xcopy %serverSource%\binaries %ServerDeploy% /E /I /Y

:: mission file
xcopy %serverSource%\MPMissions %serverDeploy%\MPMissions /E /I /Y

:: profile
xcopy %serverSource%\profile %serverDeploy%\cfgdayz /E /I /Y

copy %root%\startup_batch_files\start_server.bat %serverDeploy%


:: restart server
:: sc \\192.168.56.101 start dayz-vanilla