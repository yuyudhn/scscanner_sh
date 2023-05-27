# scscanner - Massive Status Code Scanner
scscanner is tool to read website status code response from the lists. This tool have ability to filter only spesific status code, and save the result to a file.

## Feature
- Slight dependency. This tool only need **curl** to be installed
- Multi-processing. Scanning will be more faster with multi-processing
- Filter status code. If you want only spesific status code (ex: 200) from the list, this tool will help you

## Usage
```
➜  scscanner_sh git:(main) ✗ bash scscanner.sh
 ___ __ ___ __ __ _ _ _  _ _  ___ _ _  
(_-</ _(_-</ _/ _` | ' \| ' \/ -_) '_|
/__/\__/__/\__\__,_|_||_|_||_\___|_|   
      Massive HTTP Status Code Scanner 

A Tool that read/checks website's HTTP response code from the lists.
Usage:
scscanner.sh [-l <domain.txt>] [-t {int}] [-o <out.txt>]
scscanner.sh [-h]

Options:
-l     File contain lists of domain.
-t     Adjust multi process. (Default: 15)
-f     Filter status code.
-o     Save to file.
-h     Print this Help.
```
Adjust multi-process
```
bash scscanner.sh -l domain.txt -t 30
```
Using status code filter
```
bash scscanner.sh -l domain.txt -f 200
```
Using status code filter and save to file.
```
bash scscanner.sh -l domain.txt -f 200 -o result.txt
```

## Screenshot
![scscanner](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYfMo4fSWBtsIyRAiF3IBJ9yZxkPnMAsqB8-xap665fIboPuDUMGKMwVcYFfPrwCpDVPbk3fZcY9VhWIKCL1j0haNm0L70G4kiKQ9vYPAYeexNy8Zs9wg_zLbzhBhO2a5HNq186r1DI9XCWgJ1L1w2dgUZGC_UIAZz9w1rv_UogYPQaLe6EAtdoCr5Hg/s800/scscanner_sh.png "scscanner")

# To do List
- [x] Add multi-processing
- [x] Add filter status code options
- [x] Add save to file options
- [ ] Get title from page

Feel free to contribute if you want to improve this tools.
