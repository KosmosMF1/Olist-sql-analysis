# Olist E-Commerce SQL Analysis

SQL-проект по исследованию данных бразильского маркетплейса Olist.

> Проект находится в разработке.

## О проекте

Цель проекта — провести исследовательский и бизнес-анализ данных
e-commerce с использованием PostgreSQL.

В рамках проекта база данных была развернута локально в PostgreSQL,
после чего исходные CSV-файлы были преобразованы в связанную
реляционную структуру.

## Данные

Используется Brazilian E-Commerce Public Dataset by Olist.

Датасет содержит информацию примерно о 100 тысячах заказов,
совершённых на маркетплейсе Olist.

Основные сущности:

- customers — покупатели
- orders — заказы
- order_items — товары внутри заказов
- products — товары
- sellers — продавцы
- payments — платежи
- reviews — отзывы
- product_category_translation — перевод категорий товаров

## Стек

- PostgreSQL
- SQL
- DBeaver
- Git / GitHub

## Структура проекта

```text
sql/
├── 00_create_tables.sql
└── 01_database_overview.sql