#!/bin/bash
pip install -r requirements.txt

if [ $1 == "migrate" ]
then
    cd excel_processing && bash run.sh
fi

if [ $1 == "result" ]
then
    cd db_to_ui && bash run.sh
fi
