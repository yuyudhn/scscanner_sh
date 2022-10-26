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
![scscanner](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjm5oYqNvgE7vpUg2VNklMtLFIhzU0KF9c3hdAvVXNE4DOnkwkGdSZRl5g_YsjyeOenZvuy_FAw7GWcB23sk1MOTe-pzUgss7ZZguqYOpU-0eQFHgTsmdt7LMy5SAy_5B9AblvJvCecKXfsPSVzb6L8sBYzUUpFJFnett8CMjN9hkkru7tuRo_AJx_JhQ/s708/scscanner.png "scscanner")

![scscanner filter](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjbAhYbQK55f4GMTAPtPNs2qminL5YEzj36k98d2nLz2YW2zdtaTqGovtDLCtpj8JNSyaMcDKqQOakxC4o3mVUVihaue8Q7e8hFkrkButog2eq9VnjPfMZi5nzt-jglVzZfs6wdeX1ZHK3oZmMlkAh3cBGQK-FgPFIWY8CxG9l6V1nCP_0cPjAymsTGHg/s708/scscanner%20saved%20result.png "scscanner filter result")


# To do List
- [x] Add multi-processing
- [x] Add filter status code options
- [x] Add save to file options
- [ ] Get title from page

Feel free to contribute if you want to improve this tools.
