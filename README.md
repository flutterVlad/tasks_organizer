# tasks_organizer

## Задачи:
  - ✅: Сделать авторизацию:
      - ✅ Подключить FirebaseAuth
      - ✅ Подключить Cloud Firestore для хранения информации о юзере
      - ✅ Прописать слой Data (**AuthRepositoryImpl**, **UserEntity**, **UserMapper**, **UserProvider**)
      - ✅ Прописать слой Domain (**AuthRepository**, **UserModel**, **AuthUseCases**)
  - ✖️: Прописать основной функционал приложения:
      - ✅ Подключить Hive для хранения информации локально
      - ✅ Прописать Data слой (**TaskProvider**, **HiveProvider**, **TaskRepositoryImpl**, **TaskEntity**, **TaskMapper**)
      - ✅ Прописать Domain слой (**TaskRepository**, **TaskModel**, **TaskUseCases**)
      - ✖️ Реализовать возможности:
          - ✅ Создание таски с **Названием**, **Описанием** и **сроком выполения**
          - ✖️ **Фильтрация** и **Сортировка** тасок
          - ✅ Отмечать задачи как выполненые
          - ✅ Удаление задач
          - ✖️ Получать уведомление о скором приближении срока выполнения задачи
  - ✖️ UI:
      - ✅ Реализовать экран аутентификации
      - ✅ Реализовать экран тасок
      - ✖️ Реализовать экран создания тасок
  - ✖️ Написать тесты
  - [ ] Документация
