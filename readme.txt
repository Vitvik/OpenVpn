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
Lambda Function
Terraform — створює EC2 у вибраному регіоні
S3 - для зберігання terraform.tfstate


3 частина
Ansible — встановлює та налаштовує OpenVPN, додає користувачів та генерує .ovpn файли та копіює їх в S3 
