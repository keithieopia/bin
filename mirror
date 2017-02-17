#!/bin/bash

# this script determines the number of subdirectories in a url and
# passes --cut-dirs to wget, while maintaining subdirectories for
# assets like images and css. For instance:
#
#   URL:         mysite.com/2017/01/01/my-fantastic-blog-post
#   default:     ~/download-dir/2017/01/01/my-fantastic-blog-post/index.html
#   this script: ~/download-dir/index.html

# PARSE URL:
# sed   -> remove the protocol, if it exists (http://)
# sed   -> remove trailing slash, if it exists
# fgrep -> list slashes
# wc    -> count slashes
subdirs=$(sed 's~http[s]*://~~g' <<< "$1" | sed 's,/$,,' | fgrep -o / | wc -l)
echo "subdirs: $subdirs"
exit

# EXPLAINATION OF OPTIONS:
#   --mirror                  : recursive downloads
#   --no-parent               : restrict recursiveness to only sub-directories
#   --page-requisites         : download page assets like css + images
#   --adjust-extension        : add extensions such as .html or .css where relevant
#   --convert-links           : convert links to relative, for offline viewing
#   --no-host-directories     : don't put the requested site in a sub-directory
#   --cut-dirs=               : ignore this many subdirectories on disk
#   --                        : no more options, don't interpret further dashes
#   "$@"                      : given url to this script

wget --mirror --no-parent --page-requisites --adjust-extension --convert-links --no-host-directories --cut-dirs=$subdirs \
-- "$@"
