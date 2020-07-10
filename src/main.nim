import os
import net

proc domain(name: string): string =
    if name[0..8] == "gemini://":
        return name[9 ..< len(name)]
    else:
        return name

var
    site: string = domain(paramStr(1))
    s: Socket = newSocket()

echo site

s.connect("site.me", Port(1965))
