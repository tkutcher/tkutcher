
## Code-Folding Regions in Editor
- include a comment `<editor-fold desc="some-description">` to start the region
- and a comment `</editor-fold>` to end the region
- add `defaultstate="collapsed"` to the open attribute to default it to be collapsed.i


## Kill a process listening on a known port
Sometimes you get in this situation when running development web servers
locally, and need to kill a process running on a port:
1. Run `lsof -i :<port-number>` (replacing port-number) and note the PID
2. Run `kill -9 <PID>` to kill the process at that port.

