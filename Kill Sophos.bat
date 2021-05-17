	@echo off

	call :isAdmin

	if %errorlevel% == 0 (
		goto :run
	) else (
		echo Requesting administrative privileges...
		goto :UACPrompt
	)

	exit /b

	:isAdmin
		fsutil dirty query %systemdrive% >nul
	exit /b

	:run
		SET mypath=%~dp0
		cd %~dp0
		
		net stop "Sophos Agent"
		net stop "SAVService"
		net stop "SAVAdminService"
		net stop "Sophos AutoUpdate Service"
		net stop "Sophos Message Router"
		net stop "SntpService"
		net stop "sophossps"
		net stop "Sophos Web Control Service"
		net stop "swi_filter"
		net stop "swi_service"
		
	exit /b

	:UACPrompt
		echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
		echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

		"%temp%\getadmin.vbs"
		del "%temp%\getadmin.vbs"
	exit /B`