#! /bin/sh

if [ -z "$1" ]; then
	read -p "Please input basepath:" basepath
else
	basepath="$1"
fi

cd $basepath
time=`date "+%Y%m%d%H%M%S"`
package_name="tmp"
curr_package_name=$package_name"_"$time
mkdir $curr_package_name

if [ -z "$2" ]; then
	read -p "Please input git url:" git_loc
else
	git_loc="$2"
fi

git clone -n $git_loc $curr_package_name

mv $curr_package_name/.git ./ 

rm -rf $basepath"/"$curr_package_name

read -d '' readme <<-"_EOF_"
### 这是什么

_EOF_

echo $readme>readme.md

(
cat << EOF
node_modules/
**/*.DS_Store
npm-debug.log*
yarn-debug.log*
yarn-error.log*
EOF
) > ".gitignore"

git add .
git commit -m 'init from git'

git push