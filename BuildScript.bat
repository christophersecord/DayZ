@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
cls
::=================================================================================::
::                        Dayz Deployment Tool                                     ::
::                              R4Z0R49                                            ::
::=================================================================================::

:: home is the root directory from which client and server code is located
set home=E:\games\dayz_source\DayZ

:: tools is the location of cpbo.exe
set tools=E:\games\dayz_source\DayZ

:: location of the client and server code (the directories that will be packed into PBOs)
Set ClientCode=%home%\SQF
Set ServerCode=%home%\SQF

:: location to deploy the client PBOs
set Deploy=E:\games\dayz\clients\vanilla

:: location to deploy the server PBOs
set ServerDeploy=E:\games\dayz\servers\vanilla

:: the name of the directories into which the client and server PBOs will be placed
set ModName=@DayZ
set ServerName=@DayZ_Server

:: UNC name and service name of server (used to stop and restart the server process)
set ServerUNC = 192.168.56.101
set serverService = dayz-vanilla

::=================================================================================::
:: stop running server
:: note: service created on Windows 7 using NSSM
:: also had to add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\LocalAccountTokenFilterPolicy = 1

sc \\%ServerUNC% stop %serverService%

::=================================================================================::
:: compile and deploy client to client location AND server location                ::

mkdir %deploy%\%ModName%
mkdir %deploy%\%ModName%\addons
mkdir %ServerDeploy%\%ModName%
mkdir %ServerDeploy%\%ModName%\addons

%tools%\cpbo.exe -y -p %ClientCode%\community_crossbow %Deploy%\%ModName%\Addons\community_crossbow.pbo
copy %Deploy%\%ModName%\Addons\community_crossbow.pbo %ServerDeploy%\%ModName%\Addons\community_crossbow.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz %Deploy%\%ModName%\Addons\dayz.pbo
copy %Deploy%\%ModName%\Addons\dayz.pbo %ServerDeploy%\%ModName%\Addons\dayz.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_anim %Deploy%\%ModName%\Addons\dayz_anim.pbo
copy %Deploy%\%ModName%\Addons\dayz_anim.pbo %ServerDeploy%\%ModName%\Addons\dayz_anim.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_buildings %Deploy%\%ModName%\Addons\dayz_buildings.pbo
copy %Deploy%\%ModName%\Addons\dayz_buildings.pbo %ServerDeploy%\%ModName%\Addons\dayz_buildings.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_code %Deploy%\%ModName%\Addons\dayz_code.pbo
copy %Deploy%\%ModName%\Addons\dayz_code.pbo %ServerDeploy%\%ModName%\Addons\dayz_code.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_communityassets %Deploy%\%ModName%\Addons\dayz_communityassets.pbo
copy %Deploy%\%ModName%\Addons\dayz_communityassets.pbo %ServerDeploy%\%ModName%\Addons\dayz_communityassets.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_communityweapons %Deploy%\%ModName%\Addons\dayz_communityweapons.pbo
copy %Deploy%\%ModName%\Addons\dayz_communityweapons.pbo %ServerDeploy%\%ModName%\Addons\dayz_communityweapons.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_equip %Deploy%\%ModName%\Addons\dayz_equip.pbo
copy %Deploy%\%ModName%\Addons\dayz_equip.pbo %ServerDeploy%\%ModName%\Addons\dayz_equip.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_sfx %Deploy%\%ModName%\Addons\dayz_sfx.pbo
copy %Deploy%\%ModName%\Addons\dayz_sfx.pbo %ServerDeploy%\%ModName%\Addons\dayz_sfx.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_vehicles %Deploy%\%ModName%\Addons\dayz_vehicles.pbo
copy %Deploy%\%ModName%\Addons\dayz_vehicles.pbo %ServerDeploy%\%ModName%\Addons\dayz_vehicles.pbo

%tools%\cpbo.exe -y -p %ClientCode%\dayz_weapons %Deploy%\%ModName%\Addons\dayz_weapons.pbo
copy %Deploy%\%ModName%\Addons\dayz_weapons.pbo %ServerDeploy%\%ModName%\Addons\dayz_weapons.pbo

%tools%\cpbo.exe -y -p %ClientCode%\st_collision %Deploy%\%ModName%\Addons\st_collision.pbo
copy %Deploy%\%ModName%\Addons\st_collision.pbo %ServerDeploy%\%ModName%\Addons\st_collision.pbo

%tools%\cpbo.exe -y -p %ClientCode%\st_evasive %Deploy%\%ModName%\Addons\st_evasive.pbo
copy %Deploy%\%ModName%\Addons\st_evasive.pbo %ServerDeploy%\%ModName%\Addons\st_evasive.pbo

%tools%\cpbo.exe -y -p %ClientCode%\st_bunnyhop %Deploy%\%ModName%\Addons\st_bunnyhop.pbo
copy %Deploy%\%ModName%\Addons\st_bunnyhop.pbo %ServerDeploy%\%ModName%\Addons\st_bunnyhop.pbo

%tools%\cpbo.exe -y -p %ClientCode%\map_eu %Deploy%\%ModName%\Addons\map_eu.pbo
copy %Deploy%\%ModName%\Addons\map_eu.pbo %ServerDeploy%\%ModName%\Addons\map_eu.pbo

::=================================================================================::
:: compile and deploy server to server location                                    ::

mkdir %Serverdeploy%\%ModName%_server
mkdir %Serverdeploy%\%ModName%_server\Addons

%tools%\cpbo.exe -y -p %ServerCode%\dayz_server %ServerDeploy%\%ServerName%\Addons\dayz_server.pbo

:: binaries
xcopy %ServerCode%\..\binaries %ServerDeploy% /E /I

:: mission file
xcopy %ServerCode%\MPMissions\dayz_Mod.chernarus %ServerDeploy%\MPMissions /E /I

:: TODO: profile

::=================================================================================::
:: restart the server

sc \\%ServerUNC% start %serverService%
