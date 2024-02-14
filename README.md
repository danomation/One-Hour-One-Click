# onehouroneclick
One Hour One Life Server in one click


# Instructions:    
  Create an ubuntu 22.04 instance and run this command:   
```cd /home && mkdir ohol && cd ohol && wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && sudo bash pullAndBuildTestSystem.sh```

  To start the server on reboot type this:
```
line="@reboot cd /home/ohol/OneLife/server/ && ./OneLifeServer"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
```    


# Update to latest:
```sudo rm pullAndBuildtestSystem.sh && wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && sudo bash pullAndBuildTestSystem.sh```


# Known issues:    
powershell script:  
1. ```Docker not forwarding ports properly... I'm working to resolve it.```
