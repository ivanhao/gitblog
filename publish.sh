#!/bin/bash
php ./index.php Gitblog exportSite
sleep 10
cd ./_site
cp -R `ls ./ | grep -E -v "^(theme)$"` ../ivanhao.github.io/
sleep 5
cd ../ivanhao.github.io
git add .
git commit -m "1.0"
git push origin master
sleep 5
echo "publish done!"
exit
