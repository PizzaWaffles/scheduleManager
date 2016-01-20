# portManager
Uses upnpc to setup port fowarding automatically. Checks ports evey 5mins to make sure port is still forwarded

## Download
```git clone https://github.com/Dannyman3819/portManager.git```

## Install
```cd portManager```

```sudo ./INSTALL```

This will open a text editor. On the first file change the one line to the path of the program portmanager.

On the second file first change the top line to the working directory, then where the second comment is change
```log "Returned:$(upnpc -a $lanIP 22 5555 TCP)"```
to your port confiuration. Usage: 
```
upnpc -a <IP> <InteralPort> <ExternalPort> <Protocol>
```
You can add as many lines as you want.
