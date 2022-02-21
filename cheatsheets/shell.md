## Contents
- [Check if a directory exists](#check-if-a-directory-exists)
- [Loop over files in a directory](#loop-over-files-in-a-directory)

---

## Items

### Check if a directory exists
- Credit to [cyberciti.biz](https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/)
```sh
if [ -d "/path/to/dir" ] 
then
    echo "Directory /path/to/dir exists." 
else
    echo "Error: Directory /path/to/dir does not exists."
fi
```

```sh
if [ ! -d "/path/to/dir" ] 
then
    echo "Directory /path/to/dir DOES NOT exists." 
    exit 9999 # die with error code 9999
fi
``
`

### Loop over files in a directory
- Credit to [StackOverflow](https://stackoverflow.com/a/20796617/9970629)
```sh
for filename in /some/path/*.txt; do
	echo "$filename"
done
```
