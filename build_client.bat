@echo off

:: root directory in which client code is located
set home=E:\games\dayz_source\DayZ\client

:: location of bohemia tools
set tools=E:\games\dayz_source\DayZ\BITools

:: location of the key files
set keyFiles=E:\games\dayz_source\DayZ\keys

:: location to deploy the client files
set clientDeploy=E:\games\dayz\clients\vanilla

:: location to deploy the server files
set serverDeploy=E:\games\dayz\servers\vanilla

:: the name of the directories into which the client and server PBOs will be placed
:: also, the name of the authority name for the key
set modName=DayZ
set serverName=DayZ_Server

REM ----------- compile a single PBO -----------
if [%1] gtr [] (

	echo compiling %1

	%tools%\cpbo.exe -y -p %home%\PBOs\%1                           %clientDeploy%\@%ModName%\addons\%1.pbo
	%tools%\DSSignFile.exe %keyFiles%\%modName%.biprivatekey        %clientDeploy%\@%ModName%\addons\%1.pbo
	copy                   %clientDeploy%\@%ModName%\addons\%1.pbo  %serverDeploy%\@%ModName%\addons\%1.pbo

REM ----------- compile all PBOs -----------
) else (

	echo compiling all

	sc \\192.168.56.101 stop dayz-vanilla

	mkdir %clientDeploy%\@%modName%\addons
	mkdir %serverDeploy%\@%modName%\addons

	copy %home%\* %clientDeploy%\@%modName%
	copy %home%\* %serverDeploy%\@%modName%

	call build_client.bat community_crossbow
	call build_client.bat dayz
	call build_client.bat dayz_anim
	call build_client.bat dayz_buildings
	call build_client.bat dayz_code
	call build_client.bat dayz_communityassets
	call build_client.bat dayz_communityweapons
	call build_client.bat dayz_equip
	call build_client.bat dayz_sfx
	call build_client.bat dayz_vehicles
	call build_client.bat dayz_weapons
	call build_client.bat map_eu
	call build_client.bat st_bunnyhop
	call build_client.bat st_collision
	call build_client.bat st_evasive

	copy %keyFiles%\%modName%.bikey %clientDeploy%\keys\%modName%.bikey
	copy %keyFiles%\%modName%.bikey %serverDeploy%\keys\%modName%.bikey

	sc \\192.168.56.101 start dayz-vanilla

)