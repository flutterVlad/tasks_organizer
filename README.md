# tasks_organizer

## Приложение

Приложение написано с использованием ***CleanArchitecture*** и ***Dependency Injection***.

В приложении реализованы аутентификация и работа с задачами. Подключены `FirebaseAuth` и `FirebaseFirestore`. Пользователь сохраняется в `Hive` для выполнения автоматической авторизации и в `FirebaseFirestore` для хранения информации о нём. Задачи сохраняются как локально (в `Hive`), так и удалённо (в `Firebase`). Есть синхронизация локальных и удалённых задач. В качестве `Dependency Injection` использовался `GetIt`.

### Реализовано:
- Аутентификация и регистрация пользователя
- Создание, удаление и изменение задач
- Автоматический вход аутентифицированного пользователя
- Сохранение задач локально и удалённо
- Синхронизация задач


<details>
<summary>Скриншоты и видео</summary>

https://github.com/flutterVlad/tasks_organizer/assets/137285738/45c8f4e3-73b8-4879-bcd1-fe4f2747ef3f

![image](https://github.com/flutterVlad/tasks_organizer/assets/137285738/255e3191-513b-4c9c-bcd6-7a59890e5d8b)
![image](https://github.com/flutterVlad/tasks_organizer/assets/137285738/722b1d75-3935-403e-954a-8cc5e374f458)
![image](https://github.com/flutterVlad/tasks_organizer/assets/137285738/09467298-f53b-486c-bbac-e742c28481c9)
![image](https://github.com/flutterVlad/tasks_organizer/assets/137285738/7cc722ac-7225-4d64-98af-0deba09dadbb)


</details>


## Задачи:
  - ✅ Подключить авторизацию:
      - ✅ Подключить FirebaseAuth
      - ✅ Подключить Cloud Firestore для хранения информации о пользователе
      - ✅ Прописать слой Data (**AuthRepositoryImpl**, **UserEntity**, **UserMapper**, **UserProvider**)
      - ✅ Прописать слой Domain (**AuthRepository**, **UserModel**, **AuthUseCases**)
  - ✖️ Прописать основной функционал приложения:
      - ✅ Подключить Hive для хранения информации локально
      - ✅ Прописать Data слой (**TaskProvider**, **HiveProvider**, **TaskRepositoryImpl**, **TaskEntity**, **TaskMapper**)
      - ✅ Прописать Domain слой (**TaskRepository**, **TaskModel**, **TaskUseCases**)
      - ✖️ Реализовать возможности:
          - ✅ Создание задачи с **Названием**, **Описанием** и **сроком выполения**
          - ✖️ **Фильтрация** и **Сортировка** задач
          - ✅ Отмечать задачи как выполненые
          - ✅ Удаление задач
          - ✖️ Получать уведомление о скором приближении срока выполнения задачи
  - ✖️ UI:
      - ✅ Реализовать экран аутентификации
      - ✅ Реализовать экран задач
      - ✖️ Реализовать экран создания задач
  - ✖️ Написать тесты
  - ☑️ Документация

## Summary

Проект не доделан.





