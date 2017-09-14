# STAN CLI  [![Build Status](https://travis-ci.org/awmly/stan-cli.svg?branch=master)](https://travis-ci.org/awomersley/stan-cli)

STAN CLI is a command line interface for development on STAN admin. STAN CLI is split in to two shell scripts; a global app which will handle the core functionality inititialisaton, install, clone etc. This should live in a dir listed in the export path - eg `/usr/bin/stan`.

The second script is an app to be included locally within each project and will handle the day to day development tasks for the project. This can the be customised on a per project basis and commited back to the projects git repo. This should live in the project directory `./stan-cli`

## Install
Run the following commands as root/sudo to install the global stan application. Once the global app is installed you will be able to run commands to install a new project or clone an existing project which will install the local app.

```shell
wget https://raw.githubusercontent.com/awmly/stan-cli/master/stan -O /usr/local/bin/stan
chmod +x /usr/local/bin/stan
```

## Available Commands

All commands are run within the terminal using the prefix `stan` and then specifying the required method. eg `stan install`. When a command is run it gets sent to the global app `/usr/bin/stan`, if the method is defined within the global app it is executed, if it's not defined the global app sends the command to the local app within your cwd (current working directory) `./stan-cli`.

**L** - Denotes command to be run on local server

**R** - Denotes command to be run on remote server


### Global Commands

##### Remote (R)
`stan remote` - This will configure the remote server ready for the project and MUST be run before running the install command on the local server. The command needs to be run within the projetcs vhost directory eg `var/www/vhosts/project-name.co.uk` - this command will prompt for your sudo password.

##### Init (L)
`stan init` - This will clone the stan repository in to your cwd. After the project has been initialised you will need to edit `httpdocs/config/config.php` before running the install command.

##### Install (L)
`stan install` - This will install the project, databases, node modules, bower components, composer classes, build the js/css libraries, do an ititial commit to git and upload to the remote server.

##### Clone (L)
`stan clone` - This will clone an existing project in to your cwd. Please not the name of your cwd must match the git remote path.

##### Update - Local (L)
`stan update` - This will update `./stan-cli` with the latest version from this repo. Note - this will overwrite any custom methods you have added to the current project.

##### Update - Global (L/R)
`stan update global` - This will update `/usr/bin/stan` with the latest version from this repo. Requires su permissions.


### Local Commands

##### Default (L)
`stan` - To start developing on a project simply run the stan command with no added method. This will start the mysql server, http server, open atom and open chrome.

##### Build (L)
`stan build` - This will check for bower updates, recompile bower components and project specific less/js.

##### Upload (L)
`stan upload` - This will upload to the remote server. If `$STAGING_SERVER` is set to true then it will upload to `staging/` else it will upload to `httpdocs/`.

##### Rebase (L)
`stan rebase` - This will rebase the with the remote repo. A stash will be created and re-applied if required.

##### Speedtests (L)
`stan speedtests` - This will run speedtests using gtmetrix and sitespeed.io.

##### Optimise (L)
`stan optimise` - This will optimise images used within the project.

##### Database - Create Configs (L/R)
`stan db conf` - This will create mysql.cnf files for the local, staging and production databases. This command will only need to be run if values change within `httpdocs/config/config.php`.

##### Database - Sync Local (L)
`stan db synclocal` - Exports the current staging or production database (based on `$STAGING_SERVER` value) and loads it in to the local mysql server.

##### Database - Export Local (L)
`stan db exportlocal` - Export the current local database to `database/database.sql`.

##### Database - Import Local (L)
`stan db importlocal` - Import `database/database.sql` in to the local mysql server.

##### Database - Export Staging (L/R)
`stan db exportstaging` - Export the current staging database to `database/database.sql`.

##### Database - Import Staging (L/R)
`stan db importstaging` - Import `database/database.sql` in to the staging mysql server.

##### Database - Export Production (L/R)
`stan db exportproduction` - Export the current production database to `database/database.sql`.

##### Database - Import Production (L/R)
`stan db importproduction` - Import `database/database.sql` in to the production mysql server.

##### Deploy (R)
`stan deploy` - This will deploy the current project/database from staging to production. A snapshot of tje production environment is automatically created.

##### Snapshot (R)
`stan snapshot` - Create a snapshot of the current production environment. This will create an archive of the current httpdocs directory along with a copy of the production database. It will be stored in `snapshots/[sitename]-[timestame].tar.gz`.

##### Restore (R)
`stan restore snapshots/[filename]` - This will delete the current production environment (no snapshot taken) and load in the specified snapshot.
