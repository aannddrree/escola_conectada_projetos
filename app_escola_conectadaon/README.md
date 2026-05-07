# App Escola Conectada

App Flutter didático para comunicação entre pais e professores.

## Antes de executar

1. Suba a API Spring Boot.
2. Ajuste o arquivo `lib/services/api_config.dart` conforme o ambiente:

```dart
static const String baseUrl = 'http://localhost:8080';
```

No emulador Android, use:

```dart
static const String baseUrl = 'http://10.0.2.2:8080';
```

## Executar

```bash
flutter pub get
flutter run
```

## Funcionalidades

- Cadastro de responsáveis
- Cadastro de alunos
- Cadastro de professores
- Envio de comunicados
- Listagem de comunicados
- Resposta aos comunicados
