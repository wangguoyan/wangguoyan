
# sh /Users/wgy/Downloads/work/wangguoyan/code/shell/git/push.sh

git stash

git config --global http.proxy 127.0.0.1:15236
git config --global https.proxy 127.0.0.1:15236

git push

git config --global --unset http.proxy
git config --global --unset https.proxy

git stash pop