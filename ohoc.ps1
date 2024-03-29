cd ~/Desktop
Set-ExecutionPolicy -Scope CurrentUser Unrestricted
echo "Installing pre-requisites for OHOL"
if(Test-Path 'c:\windows\system32\wsl.exe'){
    echo "WSL already installed.... continuing...."
}
else {
    echo "installing WSL...."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    Read-Host -Prompt "** Manually close all powershell windows and re-run the script **"
    exit
}
$docker = Get-Service -Name com.docker.service  -ErrorAction SilentlyContinue
if($docker -eq $null){
    echo "Downloading and installing Docker"
    echo "This may take a while...."
    $ProgressPreference = 'SilentlyContinue'
    curl "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe" -o "Docker Desktop Installer.exe"
    Start-Process 'Docker Desktop Installer.exe' -Wait -ArgumentList 'install', '--quiet --accept-license'
    Read-Host -Prompt "** Manually close all powershell windows and re-run the script **"
    exit
}
else{
    echo "Docker already installed.... continuing...."
}
if(Test-Path 'C:\Program Files\Docker\Docker\Docker Desktop.exe'){
    start "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}
else{
}
echo "Start the Docker Engine in the Docker Desktop app before pressing ENTER to continue."
Read-Host -Prompt "<enter to continue>"
$container = docker ps -a -q -f name=ohoc
if(($container.Length -GE 1) -and ($container.Length -NE 61)){
    echo "Container already exists.... restarting"
    docker container stop ohoc
    docker container start ohoc
    docker exec -dit ohoc /bin/bash -c "cd /home/ohol/OneLife/server/ && echo 'type ./OneLifeServer to start server'; exec bash"}
else{
    docker run -d -p 8005:8005 --name=ohoc --tty ubuntu:22.04 /bin/bash
    docker exec -it ohoc /bin/bash -c "apt -y update; apt -y upgrade; apt-get -y update; apt-get -y upgrade; apt-get -y install sudo nano vim net-tools wget; apt-get -y install build-essential; cd /home; mkdir ohol; cd ohol; apt-get -y install wget; wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && bash pullAndBuildTestSystem.sh; exec bash"
}
