set -e
git init
chmod u+x bin/*
ls | grep -v "run.me.first.sh" | xargs git add
git add .gitignore
git commit -m "Initial commit"
echo "############################################################"
echo "# Run manually:"
echo "#   git remote add origin git@git.jacknyfe.net:{{name}}.git"
echo "#   git push"
echo "############################################################"
rm run.me.first.sh
