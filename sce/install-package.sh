#!/bin/bash
        
###############################################################################
#   Sohu Cloud Engine V2.0 (SCE) SOHU.COM Crop. Copyright@2013 
#
#       install-package.sh for pypi
#                                       pautcherzhang@sohu-inc.com
#
###############################################################################

grep=/bin/grep
chown=/bin/chown
chgrp=/bin/chgrp
cmd=$1

pypi=http://pypi.sohuapps.cn/simple
pypi_misc=http://pypi-misc.sohuapps.cn
pypi_host=pypi.sohuapps.cn
pypi_misc_host=pypi-misc.sohuapps.cn
npmjs=http://npmjs.sohuapps.cn
npmjs_misc=http://npmjs-misc.sohuapps.cn
ruby=http://rubygems.sohuapps.cn
ruby_misc=http://rubygems-misc.sohuapps.cn

package_dir=/opt/libs/$cmd
easy_install=/opt/apps/python/bin/easy_install
pip=/opt/apps/python/bin/pip
gem=/opt/apps/ruby/bin/gem
bundle=/opt/apps/ruby/bin/bundle
npm=/opt/apps/node/bin/npm
npm_install_prefix=/opt/apps/node/lib/node_modules
gem_install_prefix=/opt/apps/ruby/lib/ruby/gems/2.1.0/gems
pypi_install_prefix=/opt/apps/python/lib/python2.7/site-packages

pypirc=/opt/apps/python/lib/python2.7/distutils/distutils.cfg
gemrc=~/.gemrc

stderr_log="/opt/logs/""`ls /opt/logs/ | grep stderr`"
stdout_log="/opt/logs/""`ls /opt/logs/ | grep stdout`"
agent_log="/opt/logs/agent.log"

init_rubyrc()
{
    
    if [ -f "$gemrc" ]; then
        #rm -rf $gemrc
        return
    fi
    touch $gemrc
    echo "---">>$gemrc
    echo ":backtrace: false">>$gemrc
    echo ":bulk_threshold: 1000">>$gemrc
    echo ":update_sources: true">>$gemrc
    echo ":verbose: true">>$gemrc
    echo ":sources:">>$gemrc
    sources=`$gem sources | grep http`
    for s in sources; do
      $gem sources --remove $s
    done    
    $gem sources --remove https://rubygems.org/
    echo "- ""$ruby""/">>$gemrc
    echo "- ""$ruby_misc""/">>$gemrc
    $gem sources --add "$ruby""/"
    $gem sources --add "$ruby_misc""/"
   
    $chown -R app:app $gemrc
}

init_pypirc()
{
    
    if [ -f "$pypirc" ]; then
        rm -rf $pypirc
    fi
    touch $pypirc
    echo "[easy_install]">>$pypirc
    echo "index_url=$pypi">>$pypirc
    echo "find_links=$pypi_misc">>$pypirc
    echo "allow_hosts=$pypi_host,$pypi_misc_host">>$pypirc   
    $chown -R app:app $pypirc
    
}

mkdir -p $package_dir
$chown -R app:app $package_dir

install_packages()
{


    if [ "$cmd"x = "python"x ]; then 
        export PYTHONPATH=$package_dir
        init_pypirc   
        softs="pip"
        echo "easy softs--""$softs"
        if [ "$softs"x != ""x ]; then
          $easy_install $softs 2>>$stderr_log 1>>$stdout_log
        fi

        cd /opt/src/app
        softs=""
        rqs="/opt/src/app/requirements.txt"
        if [ -f "$rqs" ]; then 
          for p in `cat $rqs`; do
            ls $pypi_install_prefix/$p >/dev/null  2>&1 || ls $pypi_install_prefix/$p-* >/dev/null  2>&1
            if [ $? -ne 0 ]; then 
              softs="$softs"" ""$p"
            fi
          done
          echo "softs in requirements: $softs" 1>>$stdout_log &
          if [ "$softs"x != ""x ]; then
            $easy_install $softs 2>>$stderr_log 1>>$stdout_log
          fi
          for p in `cat $rqs`; do
            ls $pypi_install_prefix/$p >/dev/null  2>&1 || ls $pypi_install_prefix/$p-* >/dev/null  2>&1
            if [ $? -ne 0 ]; then 
              $easy_install $p 2>>$stderr_log 1>>$stdout_log
              sleep 1
            fi
          done
          #$pip install --index-url=$pypi --find-link=$pypi_misc --default-timeout=60 --log-file=$agent_log -r requirements.txt 2>>$stderr_log 1>>$stdout_log &
        fi

    elif [ "$cmd"x = "nodejs"x ]; then
        $npm cache clean
        softs=""
        echo "npm softs--""$softs"
        if [ "$softs"x != ""x ]; then
          $npm --registry $npmjs install $softs -g 2>>$stderr_log 1>>$stdout_log
        fi

        cd /opt/src/app
        if [ -f "/opt/src/app/package.json" ]; then          
          $npm --registry $npmjs install -g 2>>$stderr_log 1>>$stdout_log &
        fi

    elif [ "$cmd"x = "ruby"x ]; then
        init_rubyrc 2>$stderr_log
        softs=""
        echo "gem softs--""$softs"
        if [ "$softs"x != ""x ]; then
          $gem install $softs 2>>$stderr_log 1>>$stdout_log
        fi

        cd /opt/src/app        
        if [ -f "/opt/src/app/Gemfile" ]; then 
          sed -i '/^source/d' Gemfile
          sed -i "1i source '\\$ruby_misc/'" Gemfile  
          sed -i "1i source '\\$ruby/'" Gemfile      
          $bundle install 2>>$stderr_log 1>>$stdout_log &
        fi
        
    else
        echo "no runtime[$cmd] was found!"
        exit 0
    fi

}

pre_install()
{
  process_num=`ps alx | grep install-package | wc -l`
  if [ $process_num -gt 4 ]; then
    echo "install-package has more than one process running!" 1>>$stdout_log &
    exit 1
  fi
}

pre_install
install_packages
exit 0