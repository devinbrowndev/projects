import subprocess
import string

#worlds to check (only used the US worlds)
world_numbers = [
    'oldschool5.runescape.com',
    'oldschool6.runescape.com',
    'oldschool7.runescape.com',
    'oldschool13.runescape.com',
    'oldschool14.runescape.com',
    'oldschool15.runescape.com',
    'oldschool19.runescape.com',
    'oldschool20.runescape.com',
    'oldschool21.runescape.com',
    'oldschool22.runescape.com',
    'oldschool23.runescape.com',
    'oldschool29.runescape.com',
    'oldschool30.runescape.com',
    'oldschool31.runescape.com',
    'oldschool32.runescape.com',
    'oldschool37.runescape.com',
    'oldschool38.runescape.com',
    'oldschool39.runescape.com',
    'oldschool40.runescape.com',
    'oldschool46.runescape.com',
    'oldschool47.runescape.com',
    'oldschool48.runescape.com',
    'oldschool54.runescape.com',
    'oldschool55.runescape.com',
    'oldschool56.runescape.com',
    'oldschool57.runescape.com',
    'oldschool62.runescape.com',
    'oldschool69.runescape.com',
    'oldschool70.runescape.com',
    'oldschool74.runescape.com',
    'oldschool77.runescape.com',
    'oldschool78.runescape.com',
    'oldschool86.runescape.com',
    'oldschool121.runescape.com',
    'oldschool122.runescape.com'
]

#declare empty list to hold bash to parse (macOS)
world_bashes = []
#loop through world numbers
for world in world_numbers:
    latency = subprocess.check_output(["ping",world,"-c","3"]).splitlines()
    world_bashes.append(latency)


#parsing function
def parse_ping(latency):
    avg_ping = float(latency[7].decode('utf-8').split('/')[4])
    return avg_ping;

#parse and output
i=0
for bash_output in world_bashes:
    present_ping = parse_ping(bash_output)
    if present_ping <= 22:
        print('The ping of world ' + world_numbers[i] + ' is:')
        print(present_ping)
    i+=1
