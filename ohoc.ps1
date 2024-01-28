cd ~/Desktop
echo "Installing pre-requisites for OHOL"
if(Test-Path 'c:\windows\system32\wsl.exe'){
    echo "WSL already installed.... continuing...."
}
else {
    echo "installing WSL...."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
}
$docker = Get-Service -Name com.docker.service  -ErrorAction SilentlyContinue
if($docker -eq $null){
    echo "Downloading and installing Docker"
    echo "This may take a while...."
    Invoke-WebRequest -OutFile "Docker Desktop Installer.exe" -Uri https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
    Start-Process 'Docker Desktop Installer.exe' -Wait -ArgumentList 'install', '--quiet --accept-license'
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
if($container.Length -GE 1){
    echo "Container already exists.... restarting"
    docker container restart ohoc
    docker exec -it ohoc /bin/bash -c "cd /home/ohol/OneLife/server/ && ./OneLifeServer; exec bash"
}
else{
    docker run -p 8005:8005 -itd --name=ohoc --tty ubuntu:22.04 /bin/bash
    docker exec -it ohoc /bin/bash -c "apt -y update; apt -y upgrade; apt-get -y update; apt-get -y upgrade; apt-get -y install build-essential; cd /home; mkdir ohol; cd ohol; apt-get -y install wget; wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && bash pullAndBuildTestSystem.sh; exec bash"
}