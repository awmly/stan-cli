# STAN CLI
STAN CLI is a command line interface for development on STAN admin. STAN CLI is split in to two shell scripts; a global app which will handle the core functionality inititialisaton, install, clone etc. This should live in a dir listed in the export path - eg `/usr/bin/stan`.

The second script is an app to be included locally within each project and will handle the day to day development tasks for the project. This can the be customised on a per projetc basis and commited back to the projects git repo. This should live in the current working directory `./stan-cli`

## Install
Run the following commands as root/sudo to install the global stan application. Once the global app is installed you will be able to run commands to install a new project or clone an existing project which will install the local app.

```shell
wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan -O /usr/bin/stan
chmod +x /usr/bin/stan
```

## Available Commands

All commands are run within the terminal using the prefix `stan` and then specifying the required method. eg `stan install`. When a command is run it gets sent to the global app `/usr/bin/stan`, if the method is defined within the global app it is executed, if it's not defined the global app sends the command to the local app within your cwd (current working directory) `./stan-cli`.

**L** - Denotes command to be run on local server

**R** - Denotes command to be run on remote server


### Global Commands

#### Remote (R)
`stan remote` - This will configure the remote server ready for the project and MUST be run before running the install command on the local server. The command needs to be run within the projetcs vhost directory eg `var/www/vhosts/project-name.co.uk` - this command will prompt for your sudo password.

#### Init (L)
`stan init` - This will clone the stan repository in to your cwd. After the project has been initialised you will need to edit `httpdocs/config/config.php` before running the install command.

#### Install (L)
`stan install` - This will install the project, databases, node modules, bower components, composer classes, build the js/css libraries, do an ititial commit to git and upload to the remote server.

#### Clone (L)
`stan clone` - This will clone an existing project in to your cwd. Please not the name of your cwd must match the git remote path.


### Local Commands

#### Default (L)
`stan` - To start developing on a project simply run the stan command with no added method. This will start the mysql server, http server, open atom and open chrome.

