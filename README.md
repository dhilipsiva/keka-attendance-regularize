# keka-attendance-regularize

Just a RobotFramework script to regularize attendance in Keka - The HR payroll Software

# First Time Setup

Make sure you have [Python Poetry installed](https://python-poetry.org/docs/#installation).

1. Clone this repo
1. `cd` into repo
1. run `poetry install` command
1. `cp keka-sample.py keka.py` and change values in keka.py (domain, email, password, etc.)

# Regularize Attandance

1. `cd` into repo
1. Run `poetry run robot keka.robot` command

# Caveats

1. I have only tested this on Firefox.
1. The way Keka handles loaders in less than ideal. So sometimes, a loader/spinner might cause the script to fail.
1. Make sure you have appropriate [webdriver installed](https://www.selenium.dev/documentation/webdriver/getting_started/install_drivers/#quick-reference) for your browser.