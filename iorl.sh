# IORL Script


read -p "Type a character" c
if [[ "$c" =~ [I] ]]; then
    echo "This is an EYE"
elif [[ "$c" =~ [l] ]]; then
    echo "This is an ELL"
else
    echo "Non-alphabetic"
fi
