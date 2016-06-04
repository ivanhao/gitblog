#!/bin/bash
/opt/bin/php-cli ./index.php Gitblog exportSite
cd ./_site
cp -R `ls ./ | grep -E -v "^(theme)$"` ../ivanhao.github.io/
cd ../ivanhao.github.io
git pull
git add .
git commit -m "1.0"
git push origin master
echo "publish done!"
exit
