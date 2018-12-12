# #!/usr/bin/env bash

cucumber browser="headless-chrome" -t 'not @wip' -f pretty \
-f html -o build/reports/report-1.html \
-f rerun  -o build/erros/erros-1.txt
