#!/usr/bin/python

import os
import sys
import atexit
import xml.etree.ElementTree
import re

def cleanup(pidfile):
    os.unlink(pidfile)

def get_children(xml_root, kunde):
    leaf_child = []
    for child in xml_root.findall("Node"):
        if child.get("Type") == "Connection":
            if child.get("Protocol") == "SSH2":
                if kunde:
                    leaf_child.append(add_config_name(create_config(child), xml_root.get("Name")))
                else:
                    leaf_child.append(create_config(child))
        else:
            for child_child in get_children(child, kunde):
                leaf_child.append(create_config(child_child))
    return leaf_child

def create_config(xml_node):
    config = dict()
    if xml_node.get("Username").strip() == "":
        username = user
    else:
        username = xml_node.get("Username").strip()


    config["Name"] = xml_node.get("Name").strip()
    config["Username"] = username
    config["Hostname"] = xml_node.get("Hostname").strip()
    config["Port"] = xml_node.get("Port").strip()


    return config

def add_config_name(dict, name):
    dict["Name"] = normalize_string("{}.{}".format(name, dict["Name"]))
    return dict

def normalize_string(unformatted_string):
    formatted_string = unformatted_string.lower()
    formatted_string = formatted_string.replace(" ", "_")
    formatted_string = formatted_string.replace("'", "")
    formatted_string = formatted_string.replace("(", "").replace(")", "")
    formatted_string = formatted_string.replace("/", "_")
    formatted_string = formatted_string.replace("&","_und_")
    formatted_string = formatted_string.replace("..", ".")
    formatted_string = formatted_string.replace("._", "_")
    formatted_string = formatted_string.strip("_- .")
    return formatted_string

def normalize_hostname(host_dict):
    formatted_hostname = unformatted_hostname = host_dict["Name"]
    datacenters = ["hz1", "hz2", "hz3", "hz4", "hz4b", "hz5", "hz6", "dus", "haj2"]
    found_match = False
    for datacenter in datacenters:
        if datacenter in unformatted_hostname:
            formatted_hostname = "{}.{}".format(datacenter, unformatted_hostname.replace("-{}".format(datacenter), "").replace("{}".format(datacenter), ""))
            found_match = True
    if not found_match:
        formatted_hostname = "other.{}".format(unformatted_hostname)

    domains = ["hornetsecurity.com", "antispameurope.com"]
    for domain in domains:
        if domain in formatted_hostname:
            formatted_hostname = re.sub(domain, "", formatted_hostname)

    formatted_hostname = normalize_string(formatted_hostname)

    host_dict["Name"] = formatted_hostname
    return host_dict

if __name__ == "__main__":

    try:
        user = sys.argv[1]
    except:
        print("Kein Username angegeben.")
        sys.exit(5)

    basepath = os.path.dirname(os.path.realpath(__file__))
    os.chdir(basepath)

    pid_file_path = "/tmp/ssh.config-gen.pid"
    pid = str(os.getpid())

    if os.path.isfile(pid_file_path):
        print("{} already exists".format(pid_file_path))
        sys.exit(1)
    else:
        atexit.register(cleanup, pid_file_path)
        with open(pid_file_path, "w") as pid_file:
            pid_file.write(pid)

    mremote_xml_root = xml.etree.ElementTree.parse("{}/Drives/NOC - mRemote config/confCons.xml".format(os.path.expanduser("~"))).getroot()

    servers_list = []
    for child in mremote_xml_root:

        if child.attrib["Name"] == "Kunden":
            kunde = True
        else:
            kunde = False
        for child_hostname in get_children(child, kunde):
            if kunde:
                servers_list.append(child_hostname)
            else:
                servers_list.append(normalize_hostname(child_hostname))

    with open(os.path.expanduser("~/.ssh/config"), "w") as ssh_config:
        for server in servers_list:
            if server["Hostname"] is not "" and server["Name"] is not "":
                ssh_config.write("Host {}\n".format(server["Name"]))
                if server["Username"] != user:
                    ssh_config.write("\tUser {}\n".format(server["Username"]))
                ssh_config.write("\tHostname {}\n".format(server["Hostname"]))
                if server["Port"] != "" and server["Port"] != "22":
                    ssh_config.write("\tPort {}\n".format(server["Port"]))



        extra_config = """
# Jump hosts
Host jump.haj2
        Hostname 83.246.65.250
Host jump.hz1
        Hostname 10.1.70.7
Host jump.hz2
        Hostname 83.246.65.250
Host haj2.*
        ProxyJump jump.haj2
Host hz1.*
        ProxyJump jump.hz1
Host hz2.*
        ProxyJump jump.hz2
Host jump.*
        ForwardAgent yes
"""

        ssh_config.write(extra_config)

        try:
            with open("{}/.ssh/config.local".format(os.path.expanduser("~")), "r") as ssh_config_local:
                ssh_config.write("# Personal config\n")
                for line in ssh_config_local:
                    ssh_config.write(line)
        except:
            print("You can add your own config to ~/.ssh/config.local")


        common_config="""
# General config
Host *
        AddKeysToAgent yes
        User {}
""".format(user)
        ssh_config.write(common_config)

        print("Paste the following into your .bashrc\n")
        print("""function ssh {{
        if /usr/bin/ssh -oBatchMode=yes -oUser={0} $@ "true" >/dev/null 2>&1; then
                /usr/bin/ssh -oBatchMode=yes -oUser={0} $@
        else
                /usr/bin/ssh $@
        fi
}}""".format(user))