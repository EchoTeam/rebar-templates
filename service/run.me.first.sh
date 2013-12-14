set -e
make update-lock
git init
ls --ignore={deps,run.me.first.sh} | xargs git add
git add .gitignore rebar.config.lock
git commit -m "Initial commit"
git tag 0.1.0
echo "############################################################"
echo "# Run manually:"
echo "#   git remote add origin {your-new-git-remote-repo}"
echo "#   git push origin master"
echo "#   git push --tags"
echo "############################################################"
rm run.me.first.sh
