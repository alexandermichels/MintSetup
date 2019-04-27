#!/usr/bin/env python3

from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
import copy, json, os, sys
from subprocess import call

def format_command(command, codename):
    return command.replace('\"', '"').replace("$(upstream-lsb)", codename)

def getDistribCodename():
    with open("/etc/upstream-release/lsb-release") as lsb:
        lsb = lsb.readlines()
        for line in lsb:
            if "DISTRIB_CODENAME" in line:
                return line.replace("DISTRIB_CODENAME=", "").strip()

def pretty_print(_json):
    print(json.dumps(_json, sort_keys=True, indent=4))

def findMainWindow():
    # Global function to find the (open) QMainWindow in application
    app = QApplication.instance()
    for widget in app.topLevelWidgets():
        if isinstance(widget, QMainWindow):
            return widget
    return None

class App(QMainWindow):

    def __init__(self):
        super().__init__()
        self.title = 'Welcome to MintSetup!'
        self.left = 200
        self.top = 200
        self.width = 600
        self.height = 400
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        self.table_widget = MyTableWidget(self)
        self.setCentralWidget(self.table_widget)

        self.show()

class MyTableWidget(QWidget):

    def __init__(self, parent):
        super(QWidget, self).__init__(parent)
        self.layout = QVBoxLayout(self)

        # Initialize tab screen
        self.tabWindow = QTabWidget()
        self.tabs = []

        # self.listCheckBox = [general, media, code]
        self.commands = None
        self.info = {}
        with open("./bin/commands.json") as commands:
            self.commands = json.load(commands)

        self.tabLabels = []
        self.listCheckBox = []

        self.planguages = self.commands["_planguages"]
        ignore = self.commands["_ignore"]
        self.tab_desc = self.commands["_desc"]
        self.tabDesc = []
        self.checkAlls = []
        self.uncheckAlls = []

        tabCounter=0
        for key in self.commands.keys():
            if not key in ignore+self.planguages:
                self.tabLabels.append(key)
                self.tabs.append(QWidget())
                self.tabWindow.addTab(self.tabs[tabCounter], self.tabLabels[tabCounter])
                self.listCheckBox.append(list(self.commands[key].keys()))
                self.tabs[tabCounter].layout = QVBoxLayout()
                self.tabDesc.append(QLabel(self.tab_desc[self.tabLabels[tabCounter]]))
                self.tabDesc[tabCounter].setAlignment(Qt.AlignCenter)
                self.tabs[tabCounter].layout.addWidget(self.tabDesc[tabCounter])
                self.checkAlls.append(QPushButton("Select All"))
                self.checkAlls[tabCounter].clicked.connect(self.checkAll)
                self.tabs[tabCounter].layout.addWidget(self.checkAlls[tabCounter])
                self.uncheckAlls.append(QPushButton("Deselect All"))
                self.uncheckAlls[tabCounter].clicked.connect(self.uncheckAll)
                self.tabs[tabCounter].layout.addWidget(self.uncheckAlls[tabCounter])
                tabCounter+=1

        for tabCounter, l in enumerate(self.listCheckBox):
            for i, v in enumerate(l):
                self.listCheckBox[tabCounter][i] = QCheckBox(v)
                self.tabs[tabCounter].layout.addWidget(self.listCheckBox[tabCounter][i])
            self.tabs[tabCounter].layout.addStretch(1)
            self.tabs[tabCounter].setLayout(self.tabs[tabCounter].layout)

        # add Git Cache
        tabCounter+=1
        self.tabs.append(QWidget())
        self.tabLabels.append("Git")
        self.tabWindow.addTab(self.tabs[tabCounter], self.tabLabels[tabCounter])
        self.tabs[tabCounter].layout = QVBoxLayout()
        self.tabDesc.append(QLabel(self.tab_desc["Git"]))
        self.tabDesc[tabCounter].setAlignment(Qt.AlignCenter)
        self.tabs[tabCounter].layout.addWidget(self.tabDesc[tabCounter])
        self.checkAlls.append(QPushButton("Select All"))
        self.checkAlls[tabCounter].clicked.connect(self.checkAll)
        self.tabs[tabCounter].layout.addWidget(self.checkAlls[tabCounter])
        self.uncheckAlls.append(QPushButton("Deselect All"))
        self.uncheckAlls[tabCounter].clicked.connect(self.uncheckAll)
        self.tabs[tabCounter].layout.addWidget(self.uncheckAlls[tabCounter])


        self.listCheckBox.append([QCheckBox("Git")])
        self.tabs[tabCounter].layout.addWidget(self.listCheckBox[tabCounter][0])
        self.listCheckBox[tabCounter].append(QCheckBox("Git Cache"))
        self.tabs[tabCounter].layout.addWidget(self.listCheckBox[tabCounter][1])

        self.tabs[tabCounter].layout.addWidget(QLabel("Enter you Git Username here:"))
        self.GitUserNametextbox = QLineEdit(self)
        self.tabs[tabCounter].layout.addWidget(self.GitUserNametextbox)

        self.tabs[tabCounter].layout.addWidget(QLabel("Enter you Git Email here:"))
        self.GitEmailtextbox = QLineEdit(self)
        self.tabs[tabCounter].layout.addWidget(self.GitEmailtextbox)

        self.tabs[tabCounter].layout.addStretch(1)
        self.tabs[tabCounter].setLayout(self.tabs[tabCounter].layout)

        # add PLangs
        for plang in self.planguages:
            tabCounter+=1
            self.tabLabels.append(plang)
            self.tabs.append(QWidget())
            self.tabWindow.addTab(self.tabs[tabCounter], self.tabLabels[tabCounter])
            self.tabs[tabCounter].layout = QVBoxLayout()
            self.tabDesc.append(QLabel(self.tab_desc[plang]))
            self.tabDesc[tabCounter].setAlignment(Qt.AlignCenter)
            self.tabs[tabCounter].layout.addWidget(self.tabDesc[tabCounter])
            self.listCheckBox.append([])
            self.checkAlls.append(QPushButton("Select All"))
            self.checkAlls[tabCounter].clicked.connect(self.checkAll)
            self.tabs[tabCounter].layout.addWidget(self.checkAlls[tabCounter])
            self.uncheckAlls.append(QPushButton("Deselect All"))
            self.uncheckAlls[tabCounter].clicked.connect(self.uncheckAll)
            self.tabs[tabCounter].layout.addWidget(self.uncheckAlls[tabCounter])
            entries = 0
            special_checkboxes = []
            for entry in self.commands[plang]:
                if isinstance(self.commands[plang][entry], str):
                    self.listCheckBox[tabCounter].append(QCheckBox(entry))
                    self.tabs[tabCounter].layout.addWidget(self.listCheckBox[tabCounter][entries])
                    entries+=1
                else:
                    special_checkboxes.append(entry)

            for entry in special_checkboxes:
                desc = QLabel(entry)
                desc.setAlignment(Qt.AlignCenter)
                self.tabs[tabCounter].layout.addWidget(desc)
                for key in self.commands[plang][entry].keys():
                    self.listCheckBox[tabCounter].append(QCheckBox(key))
                    self.tabs[tabCounter].layout.addWidget(self.listCheckBox[tabCounter][entries])
                    entries+=1

            self.tabs[tabCounter].layout.addStretch(1)
            self.tabs[tabCounter].setLayout(self.tabs[tabCounter].layout)


        # add tabs to widget

        self.tabWindow.resize(600,400)
        self.layout.addWidget(self.tabWindow)

        # add button to bottom
        self.button = QPushButton("MintSetup")
        self.button.clicked.connect(self.on_click)
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)

    @pyqtSlot()
    def checkAll(self):
        tab = self.tabWindow.currentIndex()
        for checkbox in self.listCheckBox[tab]:
            checkbox.setChecked(True)

    @pyqtSlot()
    def uncheckAll(self):
        tab = self.tabWindow.currentIndex()
        for checkbox in self.listCheckBox[tab]:
            checkbox.setChecked(False)

    @pyqtSlot()
    def on_click(self):
        print("\n")
        packages = []
        for l in self.listCheckBox:
            for checkbox in l:
                if checkbox.checkState():
                    packages.append(checkbox.text())

        self.any_check = {}
        for tab in range(self.tabWindow.count()):
            check = False
            for checkbox in self.listCheckBox[tab]:
                if checkbox.isChecked():
                    check = True
            self.any_check[self.tabWindow.tabText(tab)] = check

        self.info["Git-user.name"] = self.GitUserNametextbox.text()
        self.info["Git-email"] = self.GitEmailtextbox.text()
        if "Git Cache" in packages and not "Git" in packages:
            msg = QMessageBox(self)
            msg.setIcon(QMessageBox.Warning)
            reply = msg.question(self, "Please review your selections", "It appears you've chosen to set a Git Cache without installing Git. This is not recommended. Would you like to install Git as well?", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if reply == QMessageBox.Yes:
                for tab in range(self.tabWindow.count()):
                    for checkbox in self.listCheckBox[tab]:
                        if checkbox.text() == "Git":
                            checkbox.setChecked(True)
                packages.append("Git")

        if "Git Cache" in packages and (self.info["Git-user.name"] == "" or self.info["Git-email"] == ""):
            msg = QMessageBox(self)
            msg.setIcon(QMessageBox.Warning)
            reply = msg.question(self, "Please review your selections", "It appears you've chosen to set a Git Cache without providing credentials. This is not recommended. Would you like to enter credentials?", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)

        for plang in self.planguages:
            code_packages = set()
            for name, command in self.commands[plang].items():
                if isinstance(command, str):
                    code_packages.add(name)
                elif not isinstance(command, str):
                    for package, _command in command.items():
                        code_packages.add(package)
            code_packages.remove(plang)

            if len(code_packages & set(packages)) > 0 and not (plang in packages):
                msg = QMessageBox(self)
                msg.setIcon(QMessageBox.Warning)
                reply = msg.question(self, "Please review your selections", "It appears you've chosen to install one or more {} packages without installing {}. This is not recommended. Would you like to install {}?".format(plang, plang, plang), QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
                if reply == QMessageBox.Yes:
                    for tab in range(self.tabWindow.count()):
                        for checkbox in self.listCheckBox[tab]:
                            if checkbox.text() == plang:
                                checkbox.setChecked(True)
                    packages.append(plang)

        code_packages = set()
        for name, command in self.commands["Python 3"].items():
            if not isinstance(command, str):
                if name == "Pip Packages":
                    for package, _command in command.items():
                        code_packages.add(package)
        print(code_packages)

        if len(code_packages & set(packages)) > 0 and not ("Pip" in packages):
            msg = QMessageBox(self)
            msg.setIcon(QMessageBox.Warning)
            reply = msg.question(self, "Please review your selections", "It appears you've chosen to install one or more Python 3 Pip packages without installing Pip. This is not recommended. Would you like to install Pip?", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if reply == QMessageBox.Yes:
                for tab in range(self.tabWindow.count()):
                    for checkbox in self.listCheckBox[tab]:
                        if checkbox.text() == "Pip":
                            checkbox.setChecked(True)
                packages.append("Pip")

        msg = QMessageBox(self)
        msg.setIcon(QMessageBox.Question)
        reply = msg.question(self, "Are you sure?", "Would you like to start setting up your computer with the selections you've made?", QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if reply == QMessageBox.Yes:
            self.makeSetupBashScript(packages)

    def msgbtn(self, i):
        print("Button pressed is: {}".format(i.text()))

    def makeSetupBashScript(self, packages):
        codename = getDistribCodename()
        break_text = "\n\n\n ##########################################################\n\n     {}\n\n ##########################################################\n\n\n"
        if codename == None:
            print("There was an error in parsing the distribution codename.....\n.....Exiting app now")
            sys.exit()
        else:
            print("   MMMMMMMMMMMMMMMMMMMMMMMMMmds+.      \n   MMm----::-://////////////oymNMd+`  \n   MMd      /++                -sNMd:    \n   MMNso/`  dMM    `.::-. .-::.` .hMN: \n   ddddMMh  dMM   :hNMNMNhNMNMNh: `NMm  \n       NMm  dMM  .NMN/-+MMM+-/NMN` dMM \n       NMm  dMM  -MMm  `MMM   dMM. dMM \n       NMm  dMM  -MMm  `MMM   dMM. dMM \n       NMm  dMM  -MMm  `MMM   dMM. dMM   \n       NMm  dMM  .mmd  `mmm   yMM. dMM    \n       NMm  dMM`  ..`   ...   ydm. dMM    \n       hMM- +MMd/-------...-:sdds  dMM    \n   -    NMm- :hNMNNNmdddddddddy/`  dMM   \n        -dMNs-``-::::-------.``    dMM   \n         `/dMNmy+/:-------------:/yMMM   \n           ./yd NMmMMMMMMMMMMMMMMMMMMM   \n               \.MMMMMMMMMMMMMMMMMMM \n\n\n    __  __ _       _   ____       _\n   |  \/  (_)_ __ | |_/ ___|  ___| |_ _   _ _ __\n   | |\/| | | '_ \| __\___ \ / _ \ __| | | | '_ \ \n   | |  | | | | | | |_ ___) |  __/ |_| |_| | |_) |   \n   |_|  |_|_|_| |_|\__|____/ \___|\__|\__,_| .__/   \n                                            |_|    ")
            print(break_text.format("Writing the perfect script, just for you"))

        with open("./bin/your_setup.sh", "w") as script:
            script.write("#!/usr/bin/env bash\n\n")
            script.write("# startup commands\necho \"{}\"\n{}\n\n".format(break_text.format("    .....Updating & and Upgrading....."), format_command(self.commands["_start"], codename)))

            for name, command in self.commands["_required"].items():
                script.write("{}\n".format(format_command(command, codename)))

            if self.any_check["Git"]:
                script.write("\necho \"{}\"\n\n".format(break_text.format("       .....Configuring Git.....")))
                for name, command in self.commands["Git"].items():
                    if name in packages and name == "Git Cache":
                        # TODO add warning if Git Cache checked, but no un/email
                        script.write("# installing {}\n{}\n".format(name, format_command(command, codename).replace("$(git_user_name)", self.info["Git-user.name"]).replace("$(git_email)", self.info["Git-email"])))
                    elif name in packages:
                        script.write("# installing {}\n{}\n".format(name, format_command(command, codename)))

            if self.any_check["General"]:
                script.write("\necho \"{}\"\n\n".format(break_text.format(".....Installing General Software.....")))
                for name, command in self.commands["General"].items():
                    if name in packages:
                        script.write("# installing {}\n{}\n".format(name, format_command(command, codename)))


            if self.any_check["Programming"]:
                script.write("\necho \"{}\"\n\n".format(break_text.format(".....Installing Programming Tools.....")))
                for name, command in self.commands["Programming"].items():
                    if name in packages:
                        script.write("# installing {}\n{}\n".format(name, format_command(command, codename)))


            for plang in self.planguages:
                if self.any_check[plang]:
                    script.write("\necho \"{}\"\n\n".format(break_text.format(".....Installing {} and Packages.....".format(plang))))
                    for name, command in self.commands[plang].items():
                        if isinstance(command, str) and name in packages:
                            script.write("# installing {}\n{}\n".format(name, format_command(command, codename)))
                        elif not isinstance(command, str):
                            for package, _command in command.items():
                                if package in packages:
                                    script.write("# installing {}\n{}\n".format(package, format_command(_command, codename)))

            if self.any_check["Preinstalled"]:
                script.write("\n# removing selected software\necho \"{}\"\n\n".format(break_text.format(".....Removing Selected Software.....")))
                for name, command in self.commands["Preinstalled"].items():
                    if name in packages:
                        script.write("# removing {}\n{}\n".format(name, format_command(command, codename)))

            script.write("# finishing script\necho \"{}\"\n\n{}".format(break_text.format("    .....Just Cleaning Up....."), format_command(self.commands["_finish"], codename)))
        main = findMainWindow()
        main.close()
        os.chmod("./bin/your_setup.sh", 0o755)
        rc = call("./bin/your_setup.sh")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    sys.exit(app.exec_())
