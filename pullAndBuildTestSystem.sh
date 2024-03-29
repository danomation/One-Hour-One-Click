#!/bin/sh
#this shell script is from https://github.com/jasonrohrer/OneLife/blob/master/scripts/pullAndBuildTestSystem.sh. I did not write it! I just fixed the symlink for version 409 and packaged in the requirements.
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential && sudo apt-get -y install git g++ imagemagick xclip libsdl1.2-dev libglu1-mesa-dev libgl1-mesa-dev make

if [ ! -e minorGems ]
then
        git clone https://github.com/jasonrohrer/minorGems.git
fi

if [ ! -e OneLife ]
then
        git clone https://github.com/jasonrohrer/OneLife.git
fi

if [ ! -e OneLifeData7 ]
then
        git clone https://github.com/jasonrohrer/OneLifeData7.git
fi



cd minorGems
git pull --tags

cd ../OneLife
git pull --tags

cd ../OneLifeData7
git pull --tags

rm */cache.fcz
rm */bin_*cache.fcz


cd ../OneLife

./configure 1

cd gameSource

make

echo 1 > settings/useCustomServer.ini

sh ./makeEditor.sh

ln -s ../../OneLifeData7/animations .
ln -s ../../OneLifeData7/categories .
ln -s ../../OneLifeData7/ground .
ln -s ../../OneLifeData7/music .
ln -s ../../OneLifeData7/objects .
ln -s ../../OneLifeData7/overlays .
ln -s ../../OneLifeData7/scenes .
ln -s ../../OneLifeData7/sounds .
ln -s ../../OneLifeData7/sprites .
ln -s ../../OneLifeData7/transitions .
ln -s ../../OneLifeData7/dataVersionNumber.txt .
ln -s ../../OneLifeData7/contentSettings .


cd ../server
./configure 1


awk '!/int codeVer/' server.cpp > server.cpp.test && mv server.cpp.test server.cpp
awk 'NR==69{print "int codeVer = 411;"}1' server.cpp > server.cpp.test && mv server.cpp.test server.cpp


make


ln -s ../../OneLifeData7/categories .
ln -s ../../OneLifeData7/objects .
ln -s ../../OneLifeData7/transitions .
ln -s ../../OneLifeData7/tutorialMaps .
ln -s ../../OneLifeData7/dataVersionNumber.txt .
ln -s ../../OneLifeData7/contentSettings .

git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//' > serverCodeVersionNumber.txt


echo 0 > settings/requireTicketServerCheck.ini
echo 0 > settings/forceEveLocation.ini

./OneLifeServer
