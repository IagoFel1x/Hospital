DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db;
USE hospital_db;

-- Tabela: Hospital
CREATE TABLE Hospital (
    id_hospital INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);


CREATE TABLE Ambulancia (
    id_ambulancia INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100),
    ano INT,
    id_hospital INT NOT NULL,
    FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital)
);


CREATE TABLE Funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(100),
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255) UNIQUE,
    id_hospital INT NOT NULL,
    FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital)
);


CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    telefone VARCHAR(20),
    endereco TEXT,
    sexo CHAR(1),
    data_nascimento DATE
);


CREATE TABLE FichaMedica (
    id_ficha INT PRIMARY KEY AUTO_INCREMENT,
    hist_clinico TEXT,
    alergias TEXT,
    observacoes TEXT,
    id_paciente INT NOT NULL UNIQUE, -- Relacionamento 1 para 1
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente)
);


CREATE TABLE Leito (
    id_leito INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(50),
    status VARCHAR(50) -- Ex: 'Ocupado', 'Livre', 'Manutenção'
);


CREATE TABLE Internacao (
    id_internacao INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    motivo TEXT,
    id_paciente INT NOT NULL,
    id_leito INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_leito) REFERENCES Leito(id_leito)
);

CREATE TABLE Visita (
    id_visita INT PRIMARY KEY AUTO_INCREMENT,
    data DATETIME NOT NULL,
    observacao TEXT,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente)
);


CREATE TABLE PlanoDeSaude (
    id_plano_saude INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PublicoSus', 'Particular') NOT NULL, -- Generalização/Especialização
    cobertura TEXT
);

CREATE TABLE Paciente_PlanoDeSaude (
    id_paciente INT,
    id_plano_saude INT,
    PRIMARY KEY (id_paciente, id_plano_saude),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_plano_saude) REFERENCES PlanoDeSaude(id_plano_saude)
);



CREATE TABLE Medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(100),
    crm VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255) UNIQUE
);


CREATE TABLE Consulta (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    diagnostico_geral TEXT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);


CREATE TABLE Triagem (
    id_triagem INT PRIMARY KEY AUTO_INCREMENT,
    pressao_arterial VARCHAR(10),
    temperatura DECIMAL(4, 2),
    peso DECIMAL(5, 2),
    altura DECIMAL(3, 2),
    obs TEXT
);


CREATE TABLE Exame (
    id_exame INT PRIMARY KEY AUTO_INCREMENT,
    tipo_exame VARCHAR(100) NOT NULL,
    data DATETIME NOT NULL,
    tipo_resultado VARCHAR(255),
    id_consulta INT NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);


CREATE TABLE Diagnostico (
    id_diagnostico INT PRIMARY KEY AUTO_INCREMENT,
    descricao_med TEXT,
    data DATETIME NOT NULL,
    id_exame INT NOT NULL,
    FOREIGN KEY (id_exame) REFERENCES Exame(id_exame)
);


CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100),
    descricao TEXT
);


CREATE TABLE Receita (
    id_receita INT PRIMARY KEY AUTO_INCREMENT,
    dosagem VARCHAR(100),
    frequencia VARCHAR(100),
    duracao VARCHAR(100),
    id_diagnostico INT NOT NULL,
    id_medicamento INT NOT NULL,
    FOREIGN KEY (id_diagnostico) REFERENCES Diagnostico(id_diagnostico),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

--  TABELAS DE RELACIONAMENTO

CREATE TABLE Medico_Hospital (
    id_medico INT,
    id_hospital INT,
    PRIMARY KEY (id_medico, id_hospital),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital)
);


CREATE TABLE Medico_Paciente (
    id_medico INT,
    id_paciente INT,
    PRIMARY KEY (id_medico, id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente)
);