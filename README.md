# scscanner - Massive Status Code Scanner
scscanner is tool to read website status code response from the lists. This tool have ability to filter only spesific status code, and save the result to a file.

## Feature
- Slight dependency. This tool only need **curl** to be installed
- Multi-processing. Scanning will be more faster with multi-processing
- Filter status code. If you want only spesific status code (ex: 200) from the list, this tool will help you

## Usage
```
┌──(miku㉿nakano)-[~/scscanner]
└─$ bash scscanner.sh

scscanner - Massive Status Code Scanner
Codename : EVA02

Example: bash scscanner.sh -l domain.txt -t 30
options:
-l     Files contain lists of domain.
-t     Adjust multi process. Default is 15
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
![scscanner](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjcubqAFn-aUmLEmd9PAn58Z7WHgSRPAedx-cTP4UBlnnRV78fypFP-wmvLgqMg5mWdiBGjNf65eooNJxSTKerIdL_uNjMMjVYD01WpRZq0_dm5UE9kqDac2YGM7P0IDr-VF_KK2AM9xOUMU24h9amht-yN1mziDud6CcGRLEM29eFygdlvbjMSihfzwQ/s791/scscanner.png "scscanner")

# To do List
- [x] Add multi-processing
- [x] Add filter status code options
- [x] Add save to file options
- [ ] Get title from page

Feel free to contribute if you want to improve this tools.
