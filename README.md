# onehouroneclick
One Hour One Life Server in one click


# Instructions:    
  Create an ubuntu 22.04 instance and run this command:   
```cd /home && mkdir ohol && cd ohol && wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && sudo bash pullAndBuildTestSystem.sh```

  You can also run this if you're running windows 11 instead:    
```./ohoc.ps1```    
or
```cmd /c "cd %UserProfile%\Desktop\ && curl https://raw.githubusercontent.com/danomation/onehouroneclick/main/ohoc.ps1 -o ohoc.ps1 && powershell.exe ./ohoc.ps1"```


# Update to latest:
```sudo rm pullAndBuildtestSystem.sh && wget https://raw.githubusercontent.com/danomation/onehouroneclick/main/pullAndBuildTestSystem.sh && sudo bash pullAndBuildTestSystem.sh```
