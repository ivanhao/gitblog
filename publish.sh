#!/bin/bash
php ./index.php Gitblog exportSite
rm -R ivanhao.github.io
git clone https://github.com/ivanhao/ivanhao.github.io.git
cd ./_site
cp -R `ls ./ | grep -E -v "^(theme)$"` ../ivanhao.github.io/
cd ../ivanhao.github.io
git pull
git add .
git commit -m "1.0"
git push origin master
echo "publish done!"
exit
