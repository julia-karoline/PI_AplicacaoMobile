# EcoJourney - Frontend (Flutter)

Aplicativo mobile desenvolvido com Flutter, focado em ajudar usuários a acompanhar sua pegada de carbono e adotar hábitos mais sustentáveis. O app permite o registro de metas diárias, hábitos de consumo e fornece sugestões inteligentes geradas por IA.

---

## Objetivo

Criar uma interface amigável e acessível para:

- Registrar e acompanhar **metas diárias sustentáveis**.
- Cadastrar hábitos como consumo de carne, gasolina e eletricidade.
- Calcular e exibir a **pegada de carbono estimada**.
- Fornecer sugestões sustentáveis com base nos hábitos, utilizando **IA (Google Gemini)**.
- Exibir pontuação, dias ativos e ranking pessoal.

---

## Tecnologias Utilizadas

- **Flutter** (SDK multiplataforma)
- **Dart** (linguagem principal)
- **HTTP** (requisições REST)
- **Shared Preferences** (armazenamento local de token)
- **Material Design** (componentes e estilo)

---

## Como Instalar e Executar

### 1. Clone o repositório:

git clone https://github.com/julia-karoline/PI_AplicacaoMobile.git
cd ecojourney-frontend

### 2. Instale as dependências:

flutter pug get

### 3. Execute o app:

flutter run

### Autenticação: 

- O login gera um token JWT que é armazenado localmente usando SharedPreferences.
- Esse token é enviado automaticamente nas requisições protegidas.

### Principais Telas:

| Tela               | Função                                                                    |
| ------------------ | ------------------------------------------------------------------------- |
| Tela de Login      | Autenticação do usuário                                                   |
| Cadastro           | Registro de novo usuário com validação de campos                          |
| Metas Diárias      | Lista, criação, edição e exclusão de metas diárias                        |
| Hábitos de Consumo | Registro e edição de hábitos com cálculo da pegada de carbono             |
| IA - Sugestões     | Sugestões inteligentes via IA com base nos hábitos inseridos pelo usuário |
| Ranking Pessoal    | Histórico de pontos e dias ativos organizados cronologicamente            |
| Loja / Recompensas | (Futuramente) Trocar pontos por benefícios ou cupons                      |


### Backend:

- Este app consome dados da API EcoJourney Backend.
- Certifique-se de que a API está rodando antes de iniciar o aplicativo.

### Licença: 

- Projeto acadêmico de código aberto.
- Disponível para estudos, melhorias e uso educacional.