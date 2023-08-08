
# Espresso Test App

Para instalar e "testar o teste" começe pelo básico:

```
git clone https://github.com/GeBender/espresso-test.git
cd espresso-test
bundle install
```

Como usamos o adaptador de banco sqlite3 padrão de novos apps, não precisa criar um banco de dados, apenas rode as migrations
```
rails db:migrate
```

Antes de subir a aplicação, crie um arauivo `.env` e sete essas 3 variáveis, as duas primeiras é para o envio de e-mails (precisa ser um Gmail) e a terceira é para o duplo fator de autenticação:
```
SENDER_USERNAME=seuemail@gmail.com
SENDER_PASSWORD=senha_de_app_do_gmail
OTP_SECRET_ENCRYPTION_KEY=sua_chave_opt
```
Lembre-se que para o Gmail enviar via app é preciso criar uma senha de App, ou seja, não é a sua senha de acesso normal ao Gmail.

### Pronto, agora sim, pode levantar o servidor
```
rails s
```

Fuque a vontade para rodar os testes e verificar a cobertura de testes em: `/covarage`
```
rails t
```

## Features e casos de teste
### Cadastro:

    - acesse o endereço http://localhost:3000 e aparecerá a tela de login
    - Clique em cadastre-se
    - Digite um e-mail, uma senha e confirme a senha
    - Você será logado e direcionado para a home

### Logout e Login com duplo fator de autenticação por e-mail
    - Clique em sair, depois confirme
    - Digite o e-mail e a senha cadastrados anteriormente
    - Clique em entrar
    - Abra o email e copie o código que foi enviado
    - Digite no campo de confirmação
    - Clique em Confirmar

### Recuperação de senha
    - Clique em sair
    - Clique em Recuperar senha
    - Digite um outro e-mail, que não o cadastrados
    - Cloque em Recuperar senha
    - Veja o e-mail recebido, sem link

    - Clique novamente em recuperar senha
    - Digite o e-mail cadastrados
    - Clique em Recupera senha
    - Abra o e-mail recebido e clique no link enviado
    - Na tela de recuperação, digite a nova senha duas vezes
    - Clique em trocar senha

### Bloqueio de senha
    - Clique em sair
    - Digite seu email
    - Digite uma senha errada
    - Repita mais 4 vezes
    - Aguarde 10 minitos e digite o eamil e senha corretos

    - Clique em sair
    - Tente logar com uma senha errada por 5 vezes
    - Abra o e-mail de recuperação
    - Clique no link
    - Digite o login e senha corretos

### Troca de senha no app logado
    - Cliqne em Senha, no menu
    - Digite a senha atual
    - Digite a nova senha
    - Confirme a nova senha
    - Clique em editar senhas

### MFA - Ativar duplo fator de autenticação via Google Authenticator
    - Clique em MFA no menu
    - Abra o app do Google Authenticator em seu celuar
    - Toque no botão de +
    - Toque no "Lerr código QR"
    - Escaneie o QR code da tela
    - Digite o código apresentado no App, no campo de ativação
    - Clique em Ativar MFA

### Login com duplo fator de autenticação via App
    - Clique em sair
    - Atualize o app do Google Auth
    - Faça o login
    - Digite o código do app no campo de confirmação
    - Clique em confirmar

### Cancelando duplo fator de autenticação via App
    - Clique em MFA
    - Clique em Cancelar token