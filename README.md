SQL Database Practice
Проект содержит решения 13 задач по SQL для четырех различных баз данных.

Структура репозитория:
sql-database-practice/ 
│ 
├── README.md 
│ 
├── vehicles_db/ 
│ ├── create_tables.sql 
│ ├── insert_data.sql 
│ ├── task1.sql 
│ ├── task2.sql 
│ ├── expected_task1.txt 
│ └── expected_task2.txt 
│ 
├── racing_db/ 
│ ├── create_tables.sql 
│ ├── insert_data.sql 
│ ├── task1.sql 
│ ├── task2.sql 
│ ├── task3.sql 
│ ├── task4.sql 
│ ├── task5.sql 
│ ├── expected_task1.txt 
│ ├── expected_task2.txt 
│ ├── expected_task3.txt 
│ ├── expected_task4.txt 
│ └── expected_task5.txt 
│ 
├── hotels_db/ 
│ ├── create_tables.sql 
│ ├── insert_data.sql 
│ ├── task1.sql 
│ ├── task2.sql 
│ ├── task3.sql 
│ ├── expected_task1.txt 
│ ├── expected_task2.txt 
│ └── expected_task3.txt 
│ 
├── organization_db/ 
│ ├── create_tables.sql 
│ ├── insert_data.sql 
│ ├── task1.sql 
│ ├── task2.sql 
│ ├── task3.sql 
│ ├── expected_task1.txt 
│ ├── expected_task2.txt 
│ └── expected_task3.txt 
│ 
└── screenshots/ 
├── XAMPP Control Panel.png 
├── vehicles_task1.png 
├── vehicles_task2.png 
├── racing_task1.png 
├── racing_task2.png 
├── racing_task3.png 
├── racing_task4.png 
├── racing_task5.png 
├── hotels_task1.png 
├── hotels_task2.png 
├── hotels_task3.png 
├── organization_task1.png 
├── organization_task2.png 
└── organization_task3.png


Базы данных и задачи
vehicles_db - Транспортные средства
Содержит информацию об автомобилях, мотоциклах и велосипедах.

Задача 1: Найти производителей и модели спортивных мотоциклов с мощностью более 150 л.с. и ценой менее 20000 долларов.

Задача 2: Объединить данные по автомобилям, мотоциклам и велосипедам с заданными критериями.

racing_db - Автомобильные гонки
Содержит классы автомобилей, список гонок и результаты участия.

Задача 1: Определить автомобили с наименьшей средней позицией в каждом классе.

Задача 2: Найти автомобиль с наименьшей средней позицией среди всех.

Задача 3: Определить классы с наименьшей средней позицией и вывести информацию об автомобилях из этих классов.

Задача 4: Найти автомобили, средняя позиция которых лучше среднего по их классу.

Задача 5: Определить классы с наибольшим количеством автомобилей, имеющих низкую среднюю позицию (>= 3.0).

hotels_db - Бронирование отелей
Содержит отели, номера, клиентов и бронирования.

Задача 1: Найти клиентов с более чем двумя бронированиями в разных отелях.

Задача 2: Найти клиентов, у которых более двух бронирований в разных отелях и общая сумма потраченных средств превышает 500 долларов.

Задача 3: Категоризировать отели по средней стоимости номера (дешевые, средние, дорогие) и определить предпочтения клиентов.

organization_db - Структура организации
Содержит отделы, сотрудников, проекты и задачи.

Задача 1: Рекурсивно найти всех подчиненных Ивана Иванова, вывести информацию о каждом сотруднике, включая проекты и задачи.

Задача 2: Дополнить предыдущий запрос подсчетом количества подчиненных у каждого сотрудника и общего количества задач.

Задача 3: Найти всех менеджеров, имеющих подчиненных, и вывести общее количество подчиненных с учетом всех уровней.

Как запустить
Запустить XAMPP Control Panel

Запустить службы Apache и MySQL

Открыть phpMyAdmin через кнопку Admin у службы MySQL

Создать новую базу данных

Выбрать созданную базу и перейти во вкладку SQL

Выполнить скрипт create_tables.sql

Выполнить скрипт insert_data.sql

Выполнить нужный taskN.sql для получения результатов

Автоматическая проверка
В репозитории настроен GitHub Actions, который при каждом пуше автоматически проверяет все SQL-запросы. Результаты проверки можно увидеть во вкладке Actions.

Все скриншоты результатов выполнения запросов находятся в папке [`screenshots/`](screenshots/).

### vehicles_db
- [Задача 1](screenshots/vehicles_task1.png) — Yamaha YZF-R1
- [Задача 2](screenshots/vehicles_task2.png) — 5 записей (Toyota Camry, Yamaha YZF-R1, Honda Civic, Trek Domane, Giant Defy)

### racing_db
- [Задача 1](screenshots/racing_task1.png) — 8 автомобилей с наименьшей средней позицией
- [Задача 2](screenshots/racing_task2.png) — Ferrari 488 (Convertible, 1.0000, Italy)
- [Задача 3](screenshots/racing_task3.png) — Ferrari 488 и Ford Mustang
- [Задача 4](screenshots/racing_task4.png) — BMW 3 Series (3.0) и Toyota RAV4 (2.0000)
- [Задача 5](screenshots/racing_task5.png) — Audi A4, Chevrolet Camaro, Renault Clio, Ford F-150

### hotels_db
- [Задача 1](screenshots/hotels_task1.png) — Bob Brown и Ethan Hunt (по 3 бронирования)
- [Задача 2](screenshots/hotels_task2.png) — Bob Brown (820.00) и Ethan Hunt (850.00)
- [Задача 3](screenshots/hotels_task3.png) — 10 клиентов с категориями отелей

### organization_db
- [Задача 1](screenshots/organization_task1.png) — 30 сотрудников с проектами и задачами
- [Задача 2](screenshots/organization_task2.png) — + количество задач и подчиненных
- [Задача 3](screenshots/organization_task3.png) — Алексей Алексеев (4 подчиненных)

### XAMPP Control Panel
- [Скриншот](screenshots/xampp_control_panel.png) — запущенные службы Apache и MySQL