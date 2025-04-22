# 🌐 OpenVPN Deployment Platform via AWS (CloudFront + S3 + Lambda + API Gateway)
## 🇺🇦 Українська
1 частина
CloudFront + S3 + Lambda + API Gateway — запускає розгортання по кліку з UI
- випадаючий список з доступними регіонами для розгортання VPN сервера.
- кнопка для "Розгорнути VPN-сервер у [регіоні]"
    🔁 → запускає terraform apply (через Lambda / GitHub Actions)
- кнопка для "Знищити VPN-сервер у [регіоні]"
    🔁 → запускає terraform destroy
- функціонал для завантаження .ovpn файлів через UI
- обмежений доступ до сторінки / AMAZON COGNITO

2 частина
Amazon API Gateway 
/deploy
/destroy
Lambda Function(deploy, destroy)
Terraform — створює EC2 у вибраному регіоні
S3 - для зберігання terraform.tfstate


3 частина
Ansible — встановлює та налаштовує OpenVPN, додає користувачів, генерує .ovpn файли та копіює їх в S3 
Amazon API Gateway 
/download 
Lambda Function(download)
S3 - для зберігання *.ovpn

## 🇩🇪 Deutsch
Teil 1
CloudFront + S3 + Lambda + API Gateway — startet die Bereitstellung per Klick im UI

Dropdown-Liste mit verfügbaren Regionen zur VPN-Server-Bereitstellung

Button „VPN-Server in [Region] bereitstellen“
🔁 → startet terraform apply (über Lambda / GitHub Actions)

Button „VPN-Server in [Region] löschen“
🔁 → startet terraform destroy

Funktion zum Herunterladen von .ovpn-Dateien über die UI

Zugriff auf die Seite eingeschränkt / AMAZON COGNITO

Teil 2
Amazon API Gateway

/deploy

/destroy
Lambda-Funktion (deploy, destroy)
Terraform — erstellt eine EC2-Instanz in der ausgewählten Region
S3 — speichert terraform.tfstate

Teil 3
Ansible — installiert und konfiguriert OpenVPN, fügt Benutzer hinzu, generiert .ovpn-Dateien und kopiert sie nach S3
Amazon API Gateway

/download
Lambda-Funktion (download)
S3 — speichert *.ovpn-Dateien

## 🇬🇧 English
Part 1
CloudFront + S3 + Lambda + API Gateway — triggers deployment via UI click

Dropdown list with available regions for VPN server deployment

Button "Deploy VPN server in [region]"
🔁 → triggers terraform apply (via Lambda / GitHub Actions)

Button "Destroy VPN server in [region]"
🔁 → triggers terraform destroy

Functionality for downloading .ovpn files via UI

Restricted access to the page / AMAZON COGNITO

Part 2
Amazon API Gateway

/deploy

/destroy
Lambda Function (deploy, destroy)
Terraform — creates EC2 instance in the selected region
S3 — stores terraform.tfstate

Part 3
Ansible — installs and configures OpenVPN, adds users, generates .ovpn files, and copies them to S3
Amazon API Gateway

/download
Lambda Function (download)
S3 — stores *.ovpn files
