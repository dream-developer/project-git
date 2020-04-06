


# コミットIDは置きかえてください。
# sedコマンドについて：GNU前提なのでMac(BSD)は要注意。もしくはGNU用のsedをインストール。


# 第２/３章 #########################################################################################################################################################################################################################################

# 学習用の各ディレクトリを作成する ########################################################################

cd ~
rm -rf ~/study_git

mkdir ~/study_git
mkdir ~/study_git/user1
mkdir ~/study_git/user2
mkdir ~/study_git/user1/project
mkdir ~/study_git/user2

mkdir ~/study_git/server
mkdir ~/study_git/server/project.git


# 第４章 #########################################################################################################################################################################################################################################


# ローカルリポジトリを作成する ########################################################################

cd ~/study_git/user1/project

git init

ls -a


# ステータス(状態)を確認する ########################################################################

touch master.txt

echo -n 'A' >> master.txt

git status


# ステージング ########################################################################

git add master.txt

git add .

git status


# コミット ########################################################################

git commit -m "[A] master.txt A"

git status



# ログ/詳細/差分をみる ########################################################################

echo -n 'B' >> master.txt

git add .

git commit -m "[B] master.txt AB"

git log --oneline 

git show 849871c

git diff --word-diff bb86beb 849871c




# リモートリポジトリの作成 ########################################################################

cd ~/study_git/server/project.git

git init --bare --shared

cd ~/study_git/user1/project


# リモートリポジトリを登録 ########################################################################

git remote add origin ~/study_git/server/project.git

git remote -v


# プッシュ ########################################################################

git branch -a

git push origin master

git branch -a

git log --oneline



# クーロン ###############################################################################################################################

cd ~/study_git/user2

git clone ~/study_git/server/project.git

ls

cd ~/study_git/user2/project

ls -a


# 追跡ブランチ ###############################################################################################################################

git branch -vv



# 新規ブランチ作成/チェックアウト/追跡指定 ###############################################################################################################################

git branch develop

git checkout develop

git branch

echo -n 'C' >> master.txt
touch develop.txt
echo 'header' >> develop.txt
echo 'footer' >> develop.txt

git add .
git commit -m "[C] master.txt ABC / develop.txt new"

git push -u origin develop

git branch -vv



# プル ###############################################################################################################################

cd ~/study_git/user1/project

git checkout -b develop

git pull origin develop

ls

sed -i -e "2i title" develop.txt

git add . && git commit -m "[D] develop.txt 2i title"

git push origin develop



# フェッチ/マージ/競合と解決 ########################################################################

cd ~/study_git/user2/project

sed -i -e "2i body" develop.txt

git add . && git commit -m " [E] develop.txt 2i body"

git fetch origin develop

git diff --word-diff FETCH_HEAD..HEAD

git merge --no-edit

echo 'header' > develop.txt
echo 'title' >> develop.txt
echo 'body' >> develop.txt
echo 'footer' >> develop.txt

git add . && git commit -m " [F] develop.txt merge"

git push origin develop



# ブランチをマージする ########################################################################

cd ~/study_git/user1/project

git pull origin develop

git checkout master

git merge develop

git push origin master



# マージされているか確認 ########################################################################

cd ~/study_git/user2/project

git checkout master

git pull origin master

ls

echo -n 'G' >> master.txt
git add . && git commit -m "[G] master.txt ABCG"


echo -n 'H' >> master.txt

git add . &&  git commit -m "[H] master.txt ABCGH"

git push origin master

git log --graph --oneline


# 第５章 #########################################################################################################################################################################################################################################

# リセット ########################################################################

cd ~/study_git
rm -rf ~/study_git/reset

mkdir ~/study_git/reset && cd ~/study_git/reset

git clone ~/study_git/server/project.git

cd ~/study_git/reset/project

echo -n 'I' >> master.txt
git add . && git commit -m "[I] master.txt ABCGHI"

cat master.txt

git log --oneline -3

git reset --soft HEAD^

git log --oneline -3

git diff --cached --word-diff

cat master.txt

git reset --hard c5f9445

git log --oneline -3

cat master.txt

git reflog -3

git reset --hard HEAD@{1}

git log --oneline -3

cat master.txt



# リバート ########################################################################

cd ~/study_git
rm -rf ~/study_git/revert

mkdir ~/study_git/revert && cd ~/study_git/revert

git clone ~/study_git/server/project.git

cd ~/study_git/revert/project

echo -n 'I' >> master.txt
git add . && git commit -m "[I] master.txt ABCGHI"

cat master.txt

git log --oneline -3

git revert --no-edit HEAD

cat master.txt

git log --oneline -5

cat master.txt

git reset --hard HEAD^

cat master.txt

git show a31baab

git revert --no-edit -m 1 a31baab

cat develop.txt



# チェリーピック ########################################################################

cd ~/study_git
rm -rf ~/study_git/cherrypick

mkdir ~/study_git/cherrypick && cd ~/study_git/cherrypick

git clone ~/study_git/server/project.git

cd ~/study_git/cherrypick/project

git checkout -b cherrypick

sed -i -e "3i function1" develop.txt && git add . && git commit -m "[I] develop.txt 3i function1"
sed -i -e "4i function2" develop.txt && git add . && git commit -m "[J] develop.txt 4i function2"
sed -i -e "5i function3" develop.txt && git add . && git commit -m "[K] develop.txt 5i function3"

cat develop.txt

git log --oneline -3

git checkout master

cat develop.txt

git cherry-pick 0de47b3

cat develop.txt

git add . && git commit -m "[L] cherry-pick [J]"

git diff --word-diff HEAD^



# スタッシュ  ########################################################################

cd ~/study_git
rm -rf ~/study_git/stash

mkdir ~/study_git/stash && cd ~/study_git/stash

git clone ~/study_git/server/project.git

cd ~/study_git/stash/project

sed -i -e "3i method1" develop.txt

cat develop.txt

git stash save "stash method1 on the way"

git reset --hard HEAD

cat develop.txt

sed -i -e "3i bug fix" develop.txt

git add . && git commit -m "[I] bug fix"

git stash list

git stash apply stash@{0}

cat develop.txt

git stash drop stash@{0}

git stash list



# タグ ########################################################################

cd ~/study_git
rm -rf ~/study_git/tag

mkdir ~/study_git/tag && cd ~/study_git/tag

git clone ~/study_git/server/project.git

cd ~/study_git/tag/project

git log --oneline -6

$ git tag v1.0 eaaf078
$ git tag v1.1 a31baab

git tag

git log --oneline -6

git show v1.0

git log --oneline v1.0..v1.1

git diff --word-diff v1.0..v1.1

git tag --delete v1.1

git tag -a v1.2 -m "annotation message" 6634f0d

git show v1.2



# Git管理下から外す ########################################################################

cd ~/study_git
rm -rf ~/study_git/ignore

mkdir -p ~/study_git/ignore/project && cd ~/study_git/ignore/project

touch {a.txt,ignore.txt,ignore_a.js,ignore_b.js}

mkdir ignoredir && touch ignoredir/ignore2.txt

git init

git status

touch .gitignore
echo 'ignore.txt' > .gitignore
echo 'ignore_a.js' >> .gitignore
echo 'ignore_b.js' >> .gitignore
echo 'ignoredir/' >> .gitignore
cat .gitignore

git status

echo '# comment' > .gitignore
echo '*.js' >> .gitignore
echo 'ignore.txt' >> .gitignore
echo 'ignoredir/' >> .gitignore
cat .gitignore



# 第６章 #########################################################################################################################################################################################################################################

# HTTPS ########################################################################

cd ~/study_git && rm -rf ~/study_git/repohttps

mkdir ~/study_git/repohttps && cd ~/study_git/repohttps

git clone https://github.com/git-edifice/project.git

cd ~/study_git/repohttps/project

git remote -v

touch test.txt
echo 'test' > test.txt

git add . && git commit -m "test"

git push origin master



# SSH ########################################################################

cd ~/study_git && rm -rf ~/study_git/repossh

mkdir ~/study_git/repossh && cd ~/study_git/repossh

cp -ai ~/.ssh ~/.ssh_`date "+%F"`

ls ~/.ssh_`date "+%F"`

ssh-keygen -t rsa -b 4096

ls ~/.ssh

ssh -T git@github.com

git clone git@github.com:git-edifice/project.git

cd ~/study_git/repossh/project

git remote -v

ls


# プルリクエスト ########################################################################

git checkout -b develop

touch app.txt
echo 'start' > app.txt
echo 'end' >> app.txt

cat app.txt

git add . && git commit -m "develop app"

git push origin develop

git checkout -b feature-app

sed -i -e "2i methodo" app.txt
cat app.txt

git add . && git commit -m "feature-app app"

git push origin feature-app

sed -i -e "2c method" app.txt
cat app.txt

git add . && git commit -m "feature-app app fix"

git push origin feature-app

git checkout develop

git pull origin develop

cat app.txt


