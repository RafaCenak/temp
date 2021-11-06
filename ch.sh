#!/bin/sh

git filter-branch --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "rafa.cenak.@gmail.com" ];
        then
                GIT_COMMITTER_NAME="Pavel Najdekr";
                GIT_AUTHOR_NAME="Pavel Najdekr";
                GIT_COMMITTER_EMAIL="pavel.najdekr@rws.com";
                GIT_AUTHOR_EMAIL="pavel.najdekr@rws.com";
                git commit-tree "$@";
        elseif
                git commit-tree "$@";
        fi' HEAD