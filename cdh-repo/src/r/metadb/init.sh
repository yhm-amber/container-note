#! /bin/bash

addin_meta_mysql ()
{
    outsqlmk_declaring_ ()
    {
        echo 'create database if not exists `{}` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci ;' &&
        echo 'grant all on `{}`.* to "{}"@"%" identified by "{}-'"${PSWD_SUFFIX}"'" ;' &&
        echo 'show grants for "{}"@"%" ;' ;
    } &&

    (echo "$@" | xargs -n1) |

        xargs -i -- bash -c "

            $(declare -f -- outsqlmk_declaring_) &&
            $(declare -p -- PSWD_SUFFIX) &&
            outsqlmk_declaring_ " &&
    :;
} &&

addin_meta_mysql \
    hive hbase spark \
    oozie hue \
    amon rman \
    scm nav navms sentry | mysql -u root -p"root-$PSWD_SUFFIX" &&

:;
