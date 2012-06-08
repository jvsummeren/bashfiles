#!/bin/bash

hash=$(base64 $1)
urlcss="data:image/png;base64,$hash"
b64css="background-image:url($urlcss);"
ie7css="*background-image:url(/$1);"

echo -n "$hash" | pbcopy

echo -e "\nHash (also copied to clipboard):"
echo $urlcss

echo -e "\nHash as background-image:"
echo $b64css

echo -e "\nHash as background-image with IE7 fallback:"
echo -e $b64css $ie7css "\n"