#!/usr/bin/env python3
self_destruct="false";
if [[ $1 = "-d" ]] || [[ $1 = "--delete" ]]; then
    self_destruct="true";
    echo "Self destruction selected. I will delete the entire folder when I'm done."
fi

sudo apt install -y python3
sudo apt install -y python3-pip
virtualenv mintsetup
source mintsetup/bin/activate
python3 -m pip install -r requirements.txt
python3 setup.py
rm -rf mintsetup

if [ $self_destruct == "true" ]; then
    cd ..
    rm -rf ./MintSetup
fi

echo "Goodbye"
