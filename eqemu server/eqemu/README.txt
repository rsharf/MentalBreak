This is only an alternative for someone to have a server that can't compile their own or find an installer and resources, after things got shut down with the PEQ. It's a fairly easy setup with a few simple steps and downloads.

To run this server YOU NEED Perl and Mariadb installed. If you don't have them installed you can download them from their sources:

MariaDB: https://dlm.mariadb.com/3277103/MariaDB/mariadb-10.11.4/winx64-packages/mariadb-10.11.4-winx64.msi (needs prompt responses)

Strawberry Perl: https://strawberryperl.com/download/5.24.4.1/strawberry-perl-5.24.4.1-64bit.msi (just let it do a default install)


Server Folder:

After unzipping this, you will have 2 folders. eqemu (the server) and peq (the database source files) The eqemu server folder has most of what you need, BUT DOES NOT have the server binaries or maps. You need to download those. The release 23.10.3 binaries are still available from the EQEmu github release repo. You can find them here:
https://github.com/EQEmu/Server/releases/download/v23.10.3/eqemu-server-windows-x64.zip (unzip these into your main eqemu server folder.)

You can download the server maps here :
https://github.com/peqarchive/peqmaps/archive/refs/heads/main.zip (Unzip these into your eqemu/maps/ folder)


Installing MariaDB:

When installing the MariaDB, it will be prompting for user name and password. THIS will be the USER NAME AND PASSWORD FOR MYSQL ACCESS. Both you and your server config files need these credentials. Please remember, or write them down, whatever you choose.

Each time you want to log into mysql, using a windows CMD prompt, you simply type: (I am using root name as example here)
C:\>mysql -u root -p
(it will then prompt you for password)
Enter password:

Once you login to mysql, you will get a prompt:
MariaDB [(none)]>

This is where it's showing you haven't chose a database yet, but if you want to create one at this point, enter the following command at that prompt:
MariaDB [(none)]> CREATE DATABASE peq; (doesn't have to be named just "peq" you can name it anything.)

Then you tell MariaDB what database you are accessing:
MariaDB [(none)]> use peq

You will then get a prompt with database name:
MariaDB [peq]>

It's at this point you can source in the database, if you need to. But you have to have this command prompt working in the same folder where the database source files are, (before you login to mysql). In the peq folder that came with this, the database files are in there. 
MariaDB [peq]> source create_all_tables.sql

That will source all the contents from the files into your new database "peq".
There are TONS of different commands that can be used to manipulate your database, but it's really better to have a database editor, so you can see what your editing.


CONFIGS:

FIRST go into the eqemu server folder and edit both the eqemu_config.json file AND the login.json file. You need to set your own credentials in those, specific to your server.
In the database sections, the name of your database, along with username and password. The current files that came with this, has the database name set to "peq" and username "root" with "mypassword" Just change those to your own credentials.
In the section for world, the long name is currently "PEQ Dragons of Norrath" and short name is "peqdon" You can change those to yours, BUT REMEMBER, those long and short names have to match the long and short names in login_world_server table in database.

Running the server:

If all that is setup and ready to go, inside the server folder (eqemu) there is 2 files named start_server.bat and stop_server.bat
Running the start_server.bat will start the server with loginserver. You will get 5 cmd windows open, but I just minimize them while doing things. Then I run stop_server.bat to kill the server.