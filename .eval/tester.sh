#!/bin/bash

if [ -d $1/$8 ]
then
  if [ -d $1/$2 ]
  then
    user_score=0
    user_score=`expr $user_score + 1`
    [ -f $1/$2/$3 ] && user_score=`expr $user_score + 1`
    [ -f $1/$4 ] && user_score=`expr $user_score + 1`
    if [ $user_score -eq 3 ]
    then
      echo 'Preliminary local directory checks in local repository... Pass'
    else
      echo 'Preliminary local directory checks in local repository... Fail'
    fi
    cd $1
    [ `eval git branch -r | wc -l` -ge 2 ] && echo 'Branch check... Pass' || echo 'Branch check... Fail'
    git checkout master > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 1 ] && echo 'Commits check on master... Pass' || echo 'Commits check on master... Fail'
    git checkout new_branch > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 2 ] && echo 'Commits check on new_branch... Pass' || echo 'Commits check on new_branch... Fail'
    git checkout master > /dev/null 2>&1
    [ `eval cat .git/logs/HEAD | grep "$9" | wc -l` -ge 1 ] && echo 'Commit amend command check... Pass' || echo 'Commit amend command check... Fail'
    cd ..
  else
    echo 'No local directory found...'
  fi

  if [ -d $5/$6 ]
  then
    user_score=0
    user_score=`expr $user_score + 1`
    cd $5
    git clone $6 $7 > /dev/null 2>&1
    if [ -d $7/$2 ]
    then
      user_score=`expr $user_score + 1`
      [ -f $7/$2/$3 ] && user_score=`expr $user_score + 1`
    fi
    [ -f $7/$4 ] && user_score=`expr $user_score + 1`
    if [ $user_score -eq 4 ]
    then
      echo 'Preliminary remote directory checks in local repository... Pass'
    else
      echo 'Preliminary remote directory checks in local repository... Fail'
    fi
    cd $7
    [ `eval git branch -r | wc -l` -ge 3 ] && echo 'Branch check... Pass' || echo 'Branch check... Fail'
    git checkout master > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 1 ] && echo 'Commits check on master... Pass' || echo 'Commits check on master... Fail'
    git checkout new_branch > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 2 ] && echo 'Commits check on new_branch... Pass' || echo 'Commits check on new_branch... Fail'
    cd ../..
    rm -rf $5/$7
  else
    echo 'No remote directory found...'
  fi
else
  echo 'No git found in the local directory'
fi
