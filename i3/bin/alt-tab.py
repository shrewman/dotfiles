#!/usr/bin/env python3

import i3ipc

i3 = i3ipc.Connection()

def getNonEmptyWorkspaces():
    workspaces = set()
    for ws in i3.get_tree().workspaces():
        workspaces.add(ws.name)
    return sorted(workspaces, key=lambda x: int(x));

def getFocusedWorkspace():
    tree = i3.get_tree()
    focused = tree.find_focused()
    return focused.workspace().name

workspaces = getNonEmptyWorkspaces()
focused_workspace = getFocusedWorkspace()

try: 
    target = workspaces.index(focused_workspace)
    i3.command('workspace number ' + str(workspaces[target + 1]))
except IndexError:
    i3.command('workspace number ' + str(workspaces[0]))

