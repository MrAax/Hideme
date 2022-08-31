import os
choice = input('[+] to install press (Y) to uninstall press (N) >> ')
run = os.system
if str(choice) =='Y' or str(choice)=='y':

    run('chmod 777 hideme.sh')
    run('mkdir /usr/share/aut')
    run('cp hideme.sh /usr/share/aut/hideme.sh')

    cmnd=(' #! /bin/bash \n  /usr/share/aut/hideme.sh "$@"')
    with open('/usr/bin/aut','w')as file:
        file.write(cmnd)
    run('chmod +x /usr/bin/aut & chmod +x /usr/share/aut/hideme.sh')
    print('''\n\ncongratulation hideme is installed successfully \nfrom now just type \x1b[6;30;42maut\x1b[0m in terminal ''')
if str(choice)=='N' or str(choice)=='n':
    run('rm -r /usr/share/aut ')
    run('rm /usr/bin/aut ')
    print('[!] now Hideme  has been removed successfully')
