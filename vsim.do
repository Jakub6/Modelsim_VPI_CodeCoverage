run -all
coverage report -output REPORT.txt -srcfile=* -assert -directive -cvg -codeAll
coverage report -html -output REPORTxml -annotate -details -assert -directive -cvg -code bcefst -verbose -threshL 50 -threshH 90
quit -f

