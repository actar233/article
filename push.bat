@echo off
git add ./*
git commit -m '添加文章'
git push
curl https://4url.top/git/target/123456789
echo '更新完成'
pause