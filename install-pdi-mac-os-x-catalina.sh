#!/bin/bash

echo ""
echo "Do you want to install Homebrew ?"
echo ""
select yn in Yes No
do
    case $yn in
        Yes ) 
            echo "Installing Homebrew ..."
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap homebrew/cask-versions
            brew update
            break;;
        No ) 
            break;;
    esac
done

echo ""
echo "Installing AdoptOpenJDK8 ..."
echo ""

brew cask install adoptopenjdk/openjdk/adoptopenjdk8

echo ""
echo "Installing libwebkitgtk-1.0-0 ..."
echo ""

sudo apt-get install libwebkitgtk-1.0-0

echo ""
echo "Downloading Pentaho Data-Integration 9.0.0.0-423 ..."
echo ""

curl -O  https://ufpr.dl.sourceforge.net/project/pentaho/Pentaho%209.0/client-tools/pdi-ce-9.0.0.0-423.zip
unzip pdi-ce-9.0.0.0-423.zip -d /Applications/pentaho/
rm pdi-ce-9.0.0.0-423.zip

echo ""
echo "Downloading and Installing Jenv ..."
echo ""

brew install jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
cd /Applications/pentaho/
jenv local openjdk64-1.8.0.252
source ~/.zshrc

echo ""
echo "Downloading SWT.jar ..."
echo ""

curl -O https://repo1.maven.org/maven2/org/eclipse/platform/org.eclipse.swt.cocoa.macosx.x86_64/3.114.100/org.eclipse.swt.cocoa.macosx.x86_64-3.114.100.jar
cp data-integration/libswt/osx64/SWT.jar data-integration/libswt/osx64/SWT_jar
cp org.eclipse.swt.cocoa.macosx.x86_64-3.114.100.jar data-integration/libswt/osx64/SWT.jar
rm cp org.eclipse.swt.cocoa.macosx.x86_64-3.114.100.jar

echo ""
echo "Settings Permissions to Data Integration.app ..."
echo ""
sudo xattr -dr com.apple.quarantine Data\ Integration.app
cd ~ 

echo ""
echo "Do you want to open Pentaho Data Integration Now ?"
echo ""
select yn in Yes No
do
    case $yn in
        Yes ) 
            open /Applications/pentaho/data-integration/Data\ Integration.app
            break;;
        No ) 
            break;;
    esac
done

echo ""
echo ""
echo "For execute PDI (Pentaho Data-Integration) execute:"
echo ""
echo "$ cd pentaho/data-integration/"
echo "$ ./spoon.sh"
echo "$ open Data\ Integration.app"
echo ""