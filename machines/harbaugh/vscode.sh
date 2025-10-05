if [ $# -eq 0 ]; then
    # No arguments provided, use default value (current directory)
    open -a "Visual Studio Code" .
else
    # Arguments were provided, use them
    open -a "Visual Studio Code" "$@"
fi
