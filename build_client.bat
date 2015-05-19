call constants.bat

REM ----------- compile a single PBO -----------
if [%1] gtr [] (

	echo compiling %1

	%tools%\cpbo.exe -y -p %clientSource%\PBOs\%1                                    %clientDeploy%\@%ModName%\addons\%1.pbo
	%tools%\DSSignFile.exe %keyFiles%\%modName%.biprivatekey                         %clientDeploy%\@%ModName%\addons\%1.pbo
	copy                   %clientDeploy%\@%ModName%\addons\%1.pbo                   %serverDeploy%\@%ModName%\addons\%1.pbo
	copy                   %clientDeploy%\@%ModName%\addons\%1.pbo.%ModName%.bisign  %serverDeploy%\@%ModName%\addons\%1.pbo.%ModName%.bisign

REM ----------- compile all PBOs -----------
) else (

	echo compiling all

	sc \\192.168.56.101 stop dayz-vanilla

	mkdir %clientDeploy%\@%modName%\addons
	mkdir %serverDeploy%\@%modName%\addons

	copy %clientSource%\* %clientDeploy%\@%modName%
	copy %clientSource%\* %serverDeploy%\@%modName%

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

	copy %keyFiles%\%modName%.bikey %clientDeploy%\keys\
	copy %keyFiles%\%modName%.bikey %serverDeploy%\keys\

	copy %root%\starup_batch_files\start_client.bat %clientDeploy%

	sc \\192.168.56.101 start dayz-vanilla

)