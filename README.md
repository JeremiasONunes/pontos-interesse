# Pontos de Interesse - Flutter App

Este aplicativo Flutter permite gerenciar uma lista de pontos de interesse, exibindo a localização atual do usuário, calculando distâncias e permitindo o cadastro de novos pontos.

---

## Funcionalidades

- Exibição da lista de pontos cadastrados com distância em metros a partir da localização atual do usuário.
- Cadastro de novos pontos com nome, descrição, latitude e longitude.
- Atualização dinâmica da lista após cadastro.
- Uso do Flutter Bloc para gerenciamento do estado.
- Visualização da localização atual do usuário.

---

## Tecnologias Utilizadas

- Flutter
- flutter_bloc
- equatable
- (adicione outras bibliotecas usadas, como geolocator, etc.)

---

## Estrutura do Projeto

- **Bloc**  
  - `point_bloc.dart`: Lógica de eventos e estados dos pontos.
  - `point_event.dart`: Eventos do Bloc.
  - `point_state.dart`: Estados do Bloc.

- **Pages**  
  - `home_page.dart`: Tela principal com lista de pontos.
  - `add_point_page.dart`: Tela para adicionar um novo ponto.
  - `point_list_page.dart`: Tela para listar pontos (alternativa ou detalhada).

- **Widgets**  
  - `point_card.dart`: Widget para exibir cada ponto na lista.

- **Domain**  
  - Entidades e casos de uso (`AddPoint`, `GetPoints`, `GetCurrentLocation`, `CalculateDistance`).

---

## Como Rodar

1. Clone o repositório:

```bash
git clone <url-do-repo>
cd pontos_de_interesse
```

## Como Usar

- Na tela inicial, o app mostra sua localização atual e a lista de pontos com distância.
- Clique no botão **+** para adicionar um novo ponto.
- Preencha o formulário com nome, descrição, latitude e longitude.
- Salve para atualizar a lista.

## telas do aplicativo quando instalado

- tela inicial do aplicativo

![alt](./tela%20inicial.jpg)

- tela de coordenadas

![alt](./tela%20para%20adicionar%20coordenadas.jpg)

- tela adicionando coordenadas exemplo

![alt](./adicionando%20coordenandas.jpg)

- tela com a distancia

![alt](./tela%20com%20distancia.jpg)



## Observações

- A localização do usuário é obtida via `GetCurrentLocation` (a implementação depende da plataforma e permissões).
- Distâncias são calculadas entre a localização atual e cada ponto cadastrado.
- Certifique-se de permitir acesso à localização no dispositivo.
