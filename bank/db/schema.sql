create database bank;
use bank;

create table accounts (
    account_number bigint not null,
    bank_code varchar(45) not null,
    balance decimal(15,2) not null default 0.00,
    primary key (account_number, bank_code),
    check (balance >= 0)
);

create table snapshots (
    id bigint auto_increment primary key,
    created_at datetime not null DEFAULT current_timestamp,
    uptime_seconds bigint not null,
    health_state enum('OK', 'DEGRADED', 'ERROR') not null,
    active_connections int not null,
    total_commands bigint not null,
    proxy_commands bigint not null,
    error_count bigint not null,
    persistence_strategy enum('MYSQL', 'JSON') not null
);

create table command_metrics (
    command_name varchar(32) primary key,
    execution_count bigint not null,
    error_count bigint not null,
    avg_execution_ms double not null
);

create table errors (
    id bigint auto_increment primary key,
    occurred_at datetime not null default current_timestamp,
    error_type enum('NETWORK', 'PERSISTENCE', 'PROTOCOL', 'BUSINESS') not null,
    severity enum('LOW', 'MEDIUM', 'HIGH', 'CRITICAL') not null,
    message text not null
);
