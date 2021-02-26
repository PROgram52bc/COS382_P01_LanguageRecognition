#!/usr/bin/bash

ANSWER=answers.txt
DATA=data.txt
TESTERS=("perl verse.pl $DATA")

for tester in "${TESTERS[@]}"; do
	echo "***************"
	echo "tester: $tester"
	echo "answer|tester"
	diff <(cat $ANSWER) <(eval "$tester")
	if [ $? -eq 0 ]; then
		echo "tester PASSED"
	else
		echo "tester FAILED"
	fi
done

