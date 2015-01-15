Vir
===

Vir is like rebar, only it isn't rebar.
If that isn't enough to sell it I don't know what is.
Anyway, templates and system assume a usage of a [sensible Makefile system](https://github.com/id3as/erl-mk), although this is compatible with rebar based dependencies.

Download the 'vir' script, stick it in path (or in your project) and then execute it. It will download everything it needs and away you go.  Run it for info, enough said.

When I ran it this morning, this is what it told me


    vir is a tool for doing the basic Erlangy bits and bobs, see the below commands for more info
    ---

    vir upgrade
    ---
       updates the templates for vir (doesn't update this running script though)

    vir init [-t <template>] [-d <targetdir] <app_name>
    ---
      Creates a new project, optional defaults are:
      template: "empty"
      targetdir: "/home/robashton/.vir"

    vir boot
    ---
       Creates bootscripts for runnable applications
       This needs to be run whenever a new dependency is added to an application

    vir run [-m <mode>] [-c <cookie] [-k <kernelargs>] <app_name>
    ---
       Runs an application from the apps dir (by name), optional defaults are:
       defaults are:
       mode: ""
       cookie: "cookie"
       kernelargs: "-kernel inet_dist_listen_min 9100 inet_dist_listen_max 9105"

    vir release [-d]
    ---
       Creates a self extracting tar of each application and updates the versions (if available)
       -d is a dirty release (don't build deps, don't clean all)
       use with caution
       if there is an install script found in bin/install.sh in the finished release, it will be executed
       on extraction


Things it does (if you can't tell from the above)
==

- Generates new apps from templates (see templates folder)
- Creates boot scripts for easy execution of erlang apps
- (Runs those apps)
- Generates releases (self extracting self contained tars with relx)
- That's it. Everthing else is Make.



