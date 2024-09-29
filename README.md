
# Foodtech Infra RDS

Este repositório contém a infraestrutura necessária para provisionar um banco de dados Amazon RDS para o projeto Foodtech usando Terraform. O projeto utiliza módulos para organização dos recursos de segurança, sub-redes, e instâncias de banco de dados.

## Estrutura do Projeto

A estrutura de diretórios é organizada da seguinte forma:

- `main.tf`: Define os recursos principais para o RDS.
- `variables.tf`: Contém as variáveis usadas no projeto.
- `outputs.tf`: Define as saídas do Terraform, como informações de conexão com o RDS.
- `modules/`
  - `rds/`: Contém os arquivos necessários para a criação da instância do RDS.
  - `security_group/`: Configura o grupo de segurança para a instância do RDS.
  - `subnet_group/`: Configura o grupo de sub-redes para o RDS.

## Pré-requisitos

Para utilizar este repositório, você precisará de:

- [Terraform](https://www.terraform.io/downloads) instalado.
- AWS CLI configurado com permissões apropriadas para criação de recursos RDS.
- Conta AWS com acesso ao serviço RDS.

## Como Usar

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/foodtech-infra-rds.git
   ```

2. Entre no diretório do projeto:

   ```bash
   cd foodtech-infra-rds
   ```

3. Inicialize o Terraform:

   ```bash
   terraform init
   ```

4. Configure as variáveis de ambiente necessárias no arquivo `variables.tf` ou através de um arquivo de variáveis personalizadas.

5. Realize o plano de execução:

   ```bash
   terraform plan
   ```

6. Aplique a infraestrutura:

   ```bash
   terraform apply
   ```

   Confirme a execução digitando `yes` quando solicitado.

## Automação

Este repositório utiliza o GitHub Actions para realizar a automação da aplicação da infraestrutura através do workflow localizado em `.github/workflows/terraform.yml`. Esta automação garante que as mudanças feitas sejam aplicadas automaticamente.

## Limpeza

Para destruir os recursos criados, execute:

```bash
terraform destroy
```

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir pull requests e discutir melhorias.

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.
