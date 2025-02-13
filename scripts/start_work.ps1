$bvVersion = "2.13.5"

# Open Prgrams
Start-Process -FilePath "C:\Users\micro\AppData\Local\slack\slack.exe"
Start-Process -FilePath "C:\Program Files (x86)\babblevoice Desktop for Windows\babblevoice Desktop for Windows.exe"


Start-Process chrome.exe -ArgumentList "--new-tab", "https://omniis.zendesk.com/", `
"--new-tab", "https://www.babblevoice.com/a/${bvVersion}/#/", `
"--new-tab", "https://www.babblevoice.com/a/${bvVersion}/admin/#/", `
"--new-tab", "https://www.babblevoice.com/p4a/applications/babble/?newsession=1", `
"--new-tab", "https://drive.google.com/drive/my-drive", `
"--new-tab", "https://docs.google.com/spreadsheets/d/130zjkGa_aQx8b3Zg9q58CWe0ABDCm7IHICoXkyZ5hxA/edit#gid=0", `
"--new-tab", "https://calendar.google.com/calendar/u/0/r?tab=rc", `
"--new-tab", "https://docs.google.com/spreadsheets/d/1ZQJw6ZH7aTLUpazo7gj7aWyOjzp36an05SVPD0QRz1M/edit#gid=282679378"

Start-Process chrome.exe '-new-window  "https://mail.google.com/mail/u/0/#inbox" '

