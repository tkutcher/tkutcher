# Cheatsheet of things I forget how to do in python



## Pip

#### Uninstall Everything
[Stack Overflow Link](https://stackoverflow.com/a/11250821/9970629)
```sh
pip freeze | grep -v "^-e" | xargs pip uninstall -y
```


#### Private Dependencies
[Stack Overflow Link](https://stackoverflow.com/a/53706140/9970629)
```py
install_requires = [
    '<PACKAGE> @ git+<PROTOCOL>://git@gitlab.com/<PATH>.git@<REF>',
]
