#! /bin/sh

basepath=$(cd `dirname $0`; pwd)
time=`date "+%Y%m%d%H%M%S"`
package_name="tmp"
curr_package_name=$package_name"_"$time
mkdir $curr_package_name

if [ -z "$1" ]; then
	read -p "Please input git url:" git_loc
else
	git_loc="$1"
fi

git clone -n $git_loc $curr_package_name

mv $curr_package_name/.git ./ 

rm -rf $basepath"/"$curr_package_name

read -d '' readme <<-"_EOF_"
### 这是什么

_EOF_

echo $readme>readme.md

read -d '' gitignore <<-"_EOF_"

node_modules/

**/*.DS_Store

npm-debug.log*

yarn-debug.log*

yarn-error.log*

_EOF_

echo $gitignore>".gitignore"

git add .
git commit -m 'init from git'

git push